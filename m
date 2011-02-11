From: Martin Nordholts <enselic@gmail.com>
Subject: Re: git-blame.el: format of date strings
Date: Fri, 11 Feb 2011 08:56:04 +0100
Message-ID: <4D54EB94.9010008@gmail.com>
References: <87vdgm3e1k.fsf@osv.gnss.ru> <20110204014315.GB28525@elie> <87tygkm8h7.fsf@krank.kagedal.org> <201102041103.10770.jnareb@gmail.com> <87r5bom7g3.fsf@krank.kagedal.org> <87oc6sm1ef.fsf@krank.kagedal.org> <20110211022928.GA24775@elie> <20110211064247.GA26091@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>,
	Jakub Narebski <jnareb@gmail.com>,
	Xavier Maillard <zedek@gnu.org>,
	Alexandre Julliard <julliard@winehq.org>,
	Kevin Ryde <user42@zip.com.au>, git@vger.kernel.org,
	Andreas Schwab <schwab@linux-m68k.org>,
	Sergei Organov <osv@javad.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 09:12:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pno6y-0004NH-Id
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 09:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100Ab1BKIML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 03:12:11 -0500
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:45197 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712Ab1BKIMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 03:12:09 -0500
X-Greylist: delayed 1129 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Feb 2011 03:12:09 EST
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id CFBE9141C1
	for <git@vger.kernel.org>; Fri, 11 Feb 2011 08:53:17 +0100 (CET)
X-SENDER-IP: [213.113.124.107]
X-LISTENER: [smtp.bredband.net]
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAUAHp5VE3VcXxrPGdsb2JhbAAMpXQBAQEBNawOhnEviF+FXASLfIY+
X-IronPort-AV: E=Sophos;i="4.60,454,1291590000"; 
   d="scan'208";a="172133808"
Received: from c-6b7c71d5.017-113-6c756e10.cust.bredbandsbolaget.se (HELO [192.168.0.102]) ([213.113.124.107])
  by ipb2.telenor.se with ESMTP; 11 Feb 2011 08:53:17 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc13 Thunderbird/3.1.7
In-Reply-To: <20110211064247.GA26091@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166543>

Please remove me from CC in the next reply, thanks

I don't use git-blame.el any longer btw, I find this approach works 
better (adjust for your needs):

(defun programming-project-git-gui-blame ()
   (interactive)
   (shell-command (concat "cd "
                          (programming-project-get-current-source-root)
                          " && "
                          "git gui blame --line="
                          (int-to-string (line-number-at-pos nil))
                          " "
                          (buffer-file-name)
                          "&" )))


  / Martin




On 02/11/2011 07:42 AM, Jonathan Nieder wrote:
> Jonathan Nieder wrote:
>
>>   - The time format (%c) is rather verbose.  I think I prefer %D
>>     (so maybe this is a potential tweakable?).
>
> Here's what that might look like.  Sadly, format-time-string does not
> seem to have an equivalent to git log's %ar format.
>
> Signed-off-by: Jonathan Nieder<jrnieder@gmail.com>
> ---
>   contrib/emacs/git-blame.el |   10 ++++++++--
>   1 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
> index 9f60a6f..a43981e 100644
> --- a/contrib/emacs/git-blame.el
> +++ b/contrib/emacs/git-blame.el
> @@ -121,6 +121,12 @@ mode. See `git-blame-format' for more information.
>   `git-blame' mode. See `git-blame-format' for more information."
>     :group 'git-blame)
>
> +(defcustom git-blame-date-format
> +  "%c"
> +  "The format of dates specified with %t or %T passed to `git-blame-format'.
> +See `format-time-string' for more information."
> +  :group 'git-blame)
> +
>   (defun git-blame-format (info format)
>     "Use format-spec to format the blame info in INFO with the following keys:
>
> @@ -146,10 +152,10 @@ mode. See `git-blame-format' for more information.
>                      (?H . ,(car info))
>                      (?a . ,(git-blame-get-info info 'author))
>                      (?A . ,(git-blame-get-info info 'author-mail))
> -                   (?t . ,(format-time-string "%c" author-time))
> +                   (?t . ,(format-time-string git-blame-date-format author-time))
>                      (?c . ,(git-blame-get-info info 'committer))
>                      (?C . ,(git-blame-get-info info 'committer-mail))
> -                   (?T . ,(format-time-string "%c" committer-time))
> +                   (?T . ,(format-time-string git-blame-date-format committer-time))
>                      (?s . ,(git-blame-get-info info 'summary))))))
>
>   (defun git-blame-color-scale (&rest elements)



-- 

My GIMP Blog:
http://www.chromecode.com/
"Nightly GIMP, GEGL, babl tarball builds"
