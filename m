From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] diff: remove another ternary expression always evaluating to true
Date: Thu, 8 Aug 2013 22:36:51 +0100
Organization: OPDS
Message-ID: <87241414EE67485DAC10602B3BB85F2D@PhilipOakley>
References: <1375988103-29947-1-git-send-email-stefanbeller@googlemail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <Jens.Lehmann@web.de>, <johannes.schindelin@gmx.de>,
	<gitster@pobox.com>
To: "Stefan Beller" <stefanbeller@googlemail.com>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 08 23:36:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Xsp-00025c-IS
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 23:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966758Ab3HHVgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 17:36:32 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:52876 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966734Ab3HHVga (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Aug 2013 17:36:30 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgASAGcOBFJOl3GZ/2dsb2JhbABbgwaJV7VyAgIBAQIBgRkXdIIfBQEBBAEIAQEdER4BASEFBgIDBQIBAxEEAQEKJRQBBBoGBw8IBgESCAIBAgMBh20DCQqvcw2IXo0rgW2BAw2DFHQDiHOGDpovgxk7
X-IPAS-Result: AgASAGcOBFJOl3GZ/2dsb2JhbABbgwaJV7VyAgIBAQIBgRkXdIIfBQEBBAEIAQEdER4BASEFBgIDBQIBAxEEAQEKJRQBBBoGBw8IBgESCAIBAgMBh20DCQqvcw2IXo0rgW2BAw2DFHQDiHOGDpovgxk7
X-IronPort-AV: E=Sophos;i="4.89,841,1367967600"; 
   d="scan'208";a="438384745"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip01ir2.opaltelecom.net with SMTP; 08 Aug 2013 22:36:29 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231938>

From: "Stefan Beller" <stefanbeller@googlemail.com>
Sent: Thursday, August 08, 2013 7:55 PM
Subject: [PATCH] diff: remove another ternary expression always 
evaluating to true

Have these issues (and the earlier expression simplifications patches 
$gmane/231916, $gmane/231912 ) been discovered with the "STACK" tool I'd 
noted in $gmane/230542 which you were also interested in (I've not had 
chance to run the tool).

If so, it's probably worth referencing the tool and the paper which 
explains the broader issues.

Philip


> The condition before the changed line dereferences 'one' to query the 
> mode,
> so if the condition evaluates to true, the variable one must not be 
> null.
> Therefore we do not need the ternary operator depending on one, giving
> either one->path or two->path. This always evaluates to one->path, so
> we can remove the ternary operator.
>
> The condition and the usage of the ternary operator have been 
> introduced
> by the same commit (752c0c24, 2009-10-19, Add the --submodule option 
> to
> the diff option family). As that commit message refers to a 
> GitTogether
> I'd assume that patch was crafted in a hurry, so maybe overlooking the
> need for a ternary operator there.
>
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> ---
> diff.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 80f8439..f30b7e4 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2252,8 +2252,7 @@ static void builtin_diff(const char *name_a,
>  (!two->mode || S_ISGITLINK(two->mode))) {
>  const char *del = diff_get_color_opt(o, DIFF_FILE_OLD);
>  const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
> - show_submodule_summary(o->file, one ? one->path : two->path,
> - line_prefix,
> + show_submodule_summary(o->file, one->path, line_prefix,
>  one->sha1, two->sha1, two->dirty_submodule,
>  meta, del, add, reset);
>  return;
> -- 
> 1.8.4.rc1.25.gd121ba2
>
> --
