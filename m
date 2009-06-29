From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git mailinfo strips important context from patch subjects
Date: Mon, 29 Jun 2009 11:19:07 +0200
Message-ID: <4A48870B.5050802@op5.se>
References: <20090628193858.GA29467@codelibre.net> <1246219664-11000-1-git-send-email-bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Roger Leigh <rleigh@codelibre.net>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jun 29 11:19:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLD1F-0008PX-8M
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 11:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbZF2JTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 05:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbZF2JTJ
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 05:19:09 -0400
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:59704 "HELO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750778AbZF2JTJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jun 2009 05:19:09 -0400
Received: from source ([72.14.220.156]) by na3sys009aob104.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSkiHDjHJpsq+ZAXN5OOet/cqMqKw3Hy3@postini.com; Mon, 29 Jun 2009 02:19:12 PDT
Received: by fg-out-1718.google.com with SMTP id l26so974960fgb.7
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 02:19:10 -0700 (PDT)
Received: by 10.86.68.8 with SMTP id q8mr1828333fga.0.1246267150243;
        Mon, 29 Jun 2009 02:19:10 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 4sm5916370fgg.17.2009.06.29.02.19.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 02:19:09 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <1246219664-11000-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122431>

Paolo Bonzini wrote:
>> Would it be possible to change the git-mailinfo logic to use a less
>> greedy pattern match?
> 
> Like this?  (I also simplified the first part of the if condition since I
> was at it).  Anyone, feel free to resubmit it as a proper patch.
> 
> Almost-Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
> ---
>  builtin-mailinfo.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
> index 92637ac..d340ae6 100644
> --- a/builtin-mailinfo.c
> +++ b/builtin-mailinfo.c
> @@ -237,7 +237,8 @@ static void cleanup_subject(struct strbuf *subject)
>  		case '[':
>  			if ((pos = strchr(subject->buf, ']'))) {
>  				remove = pos - subject->buf;
> -				if (remove <= (subject->len - remove) * 2) {
> +				if (remove <= subject->len * 2 / 3
> +				    && memmem(subject->buf, remove, 'PATCH', 5)) {
>  					strbuf_remove(subject, 0, remove + 1);
>  					continue;
>  				}


Pardon my ignorance, but wouldn't this still remove not only
"[PATCH 4/5]", but all of [PATCH 4/5] [sbuild]" anyway? The
parameters to strbuf_remove() seem unchanged.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
