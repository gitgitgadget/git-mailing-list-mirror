From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 6/7] sha1_name: cleanup interpret_branch_name()
Date: Sun, 8 Dec 2013 09:42:55 -0000
Organization: OPDS
Message-ID: <67130C4F312A414DAB7EA610C78C9103@PhilipOakley>
References: <1386482220-18558-1-git-send-email-felipe.contreras@gmail.com> <1386482220-18558-7-git-send-email-felipe.contreras@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Felipe Contreras" <felipe.contreras@gmail.com>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 08 10:42:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vpat2-0000SV-R3
	for gcvg-git-2@plane.gmane.org; Sun, 08 Dec 2013 10:42:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012Ab3LHJml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Dec 2013 04:42:41 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:62490 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752127Ab3LHJmh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Dec 2013 04:42:37 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvYYAAE+pFJZ8YsO/2dsb2JhbABZgwc4iRCwTQEBAgGBFhd0aQEBgR8BARQBBAEBBQgBAR0RFggBASwCAwUCAQMVDCUUAQQIEAIGBxcGAQcLCAIBAgMBDASFKAcBghINAxMJuRoNhn6MfYU6gRMDiQqGEocNgxuJG4IPhTmDKTw
X-IPAS-Result: AvYYAAE+pFJZ8YsO/2dsb2JhbABZgwc4iRCwTQEBAgGBFhd0aQEBgR8BARQBBAEBBQgBAR0RFggBASwCAwUCAQMVDCUUAQQIEAIGBxcGAQcLCAIBAgMBDASFKAcBghINAxMJuRoNhn6MfYU6gRMDiQqGEocNgxuJG4IPhTmDKTw
X-IronPort-AV: E=Sophos;i="4.93,850,1378854000"; 
   d="scan'208";a="439289662"
Received: from host-89-241-139-14.as13285.net (HELO PhilipOakley) ([89.241.139.14])
  by out1.ip05ir2.opaltelecom.net with SMTP; 08 Dec 2013 09:42:34 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239042>

From: "Felipe Contreras" <felipe.contreras@gmail.com>
> The 'upstream' variable doesn't hold an "upstream", but a branch, so
> make it clearer.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
> sha1_name.c | 18 +++++++++---------
> 1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index e9c2999..e27db88 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -1072,7 +1072,7 @@ static int reinterpret(const char *name, int 
> namelen, int len, struct strbuf *bu
> int interpret_branch_name(const char *name, int namelen, struct strbuf 
> *buf)
> {
>  char *cp;
> - struct branch *upstream;
> + struct branch *branch;
>  int len = interpret_nth_prior_checkout(name, buf);
>  int tmp_len;
>
> @@ -1102,26 +1102,26 @@ int interpret_branch_name(const char *name, 
> int namelen, struct strbuf *buf)
>
>  len = cp + tmp_len - name;
>  cp = xstrndup(name, cp - name);
> - upstream = branch_get(*cp ? cp : NULL);
> + branch = branch_get(*cp ? cp : NULL);
>  /*
>  * Upstream can be NULL only if cp refers to HEAD and HEAD
>  * points to something different than a branch.

Doesn't this comment also need updating, or at least clarifying any 
contradictions between variable names and the concepts described. That 
is does "Upstream" refer to the original variable 'upstream', and now 
the final "branch" can be confused with the new variable name.

I'm not arguing against the change, rather just noting an additional 
consequence.

>  */
> - if (!upstream)
> + if (!branch)
>  die(_("HEAD does not point to a branch"));
> - if (!upstream->merge || !upstream->merge[0]->dst) {
> - if (!ref_exists(upstream->refname))
> + if (!branch->merge || !branch->merge[0]->dst) {
> + if (!ref_exists(branch->refname))
>  die(_("No such branch: '%s'"), cp);
> - if (!upstream->merge) {
> + if (!branch->merge) {
>  die(_("No upstream configured for branch '%s'"),
> - upstream->name);
> + branch->name);
>  }
>  die(
>  _("Upstream branch '%s' not stored as a remote-tracking branch"),
> - upstream->merge[0]->src);
> + branch->merge[0]->src);
>  }
>  free(cp);
> - cp = shorten_unambiguous_ref(upstream->merge[0]->dst, 0);
> + cp = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
>  strbuf_reset(buf);
>  strbuf_addstr(buf, cp);
>  free(cp);
> -- 
> 1.8.5.1+fc1.2.gebd1fb1
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
