From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 2/3] for-each-ref: introduce %(HEAD) marker
Date: Fri, 24 May 2013 21:28:46 +0100
Organization: OPDS
Message-ID: <2314A6D4A97C4D44AFEF62B9D089BDC3@PhilipOakley>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com> <1369405177-7855-3-git-send-email-artagnon@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	=?iso-8859-1?Q?Nguy=3Fn_Th=E1i_Ng=3Fc_Duy?= <pclouds@gmail.com>
To: "Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 24 22:28:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfybL-0001ut-8K
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 22:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175Ab3EXU2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 16:28:31 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:65042 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752813Ab3EXU2a (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 May 2013 16:28:30 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArcNAPnMn1FZ8Ylm/2dsb2JhbABagwiJKrkrBAEDAYEGF3SCHgUBAQQBCAEBHREeAQEhCwIDBQIBAw4HAQslFAEECBIGBxcGARIIAgECAwGHagMJCrE/DYhmjEaBbWqCemEDiGeGBIZqjgOFI4MQOw
X-IronPort-AV: E=Sophos;i="4.87,737,1363132800"; 
   d="scan'208";a="419715301"
Received: from host-89-241-137-102.as13285.net (HELO PhilipOakley) ([89.241.137.102])
  by out1.ip05ir2.opaltelecom.net with SMTP; 24 May 2013 21:28:28 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225398>

From: "Ramkumar Ramachandra" <artagnon@gmail.com>
Sent: Friday, May 24, 2013 3:19 PM
> 'git branch' shows which branch you are currently on with an '*', but
> 'git for-each-ref' misses this feature.  So, extend the format with
> %(HEAD) to do exactly the same thing.

Maybe 'isHEAD'  as a better name, or 'ifHEAD', or something to indicate 
its boolean nature.

>
> Now you can use the following format in for-each-ref:
>
>  %C(red)%(HEAD)%C(reset) %C(green)%(refname:short)%C(reset)
>
> to display a red asterisk next to the current ref.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
> builtin/for-each-ref.c | 13 +++++++++++--
> 1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 1563b25..63d3a85 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -76,6 +76,7 @@ static struct {
>  { "upstream" },
>  { "symref" },
>  { "flag" },
> + { "HEAD" },
> };
>
> /*
> @@ -683,8 +684,16 @@ static void populate_value(struct refinfo *ref)
>  v->s = xstrdup(buf + 1);
>  }
>  continue;
> - }
> - else
> + } else if (!strcmp(name, "HEAD")) {
> + const char *head;
> + unsigned char sha1[20];
> + head = resolve_ref_unsafe("HEAD", sha1, 1, NULL);
> + if (!strcmp(ref->refname, head))
> + v->s = "*";
> + else
> + v->s = " ";
> + continue;
> + } else
>  continue;
>
>  formatp = strchr(name, ':');
> -- 
> 1.8.3.rc3.2.g99b8f3f.dirty
