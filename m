From: "Alex Unleashed" <unledev@gmail.com>
Subject: Re: [PATCH] git-send-email: Add a --cc-nobody option
Date: Tue, 18 Sep 2007 14:50:10 +0200
Message-ID: <5e4707340709180550w3211e95fqd9fd648aab8ce78a@mail.gmail.com>
References: <11901157221792-git-send-email-felipebalbi@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, ae@op5.se,
	"Felipe Balbi" <felipe.lima@indt.org.br>
To: "felipebalbi@users.sourceforge.net" 
	<felipebalbi@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 14:50:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXcX1-0004gz-MD
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 14:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631AbXIRMuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 08:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753861AbXIRMuO
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 08:50:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:13861 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbXIRMuM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 08:50:12 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1427491nfb
        for <git@vger.kernel.org>; Tue, 18 Sep 2007 05:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=BqpP3gMYNwG0B/PtL/QLbyQWCevM6Hr0iSVjUqk+uy0=;
        b=c9pZpvTRcvAqoon3jJ7YBEu4dXq3ceoIrp+1uPJQPDEiA+E7M94/ESjcjb6dZ/KCw5WlMItuFAAj66l94FmJCmybwH4orWFFJHE9+jOPWpu1jB0oFodr7YtbpIS996RngQloZy/eiNQJfz/kFxPe8tw4pc5dg1gj8o4nBm1dlQo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WJH9t9HHG1Hg1xq7Mj/bCj305MZRe51ZEGu3aE01EDc6ktRg9GqVaAXLR+w/44j4WEg+qhzXCW0s+6iF7OMvQnWPP6yET8tkCnWmRCQNsdG8/Myw7A60oillSCTvUAOBdEHCsmen1Zpw4qEHDGeu/gTD9N1aDemMC/VQfBNSEwg=
Received: by 10.86.51.2 with SMTP id y2mr4621019fgy.1190119810224;
        Tue, 18 Sep 2007 05:50:10 -0700 (PDT)
Received: by 10.86.71.16 with HTTP; Tue, 18 Sep 2007 05:50:10 -0700 (PDT)
In-Reply-To: <11901157221792-git-send-email-felipebalbi@users.sourceforge.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58598>

On 9/18/07, felipebalbi@users.sourceforge.net
<felipebalbi@users.sourceforge.net> wrote:
> From: Felipe Balbi <felipe.lima@indt.org.br>
>
> This patch adds a --cc-nobody option to avoid sending emails
> to everybody but the ones listed by --to option.
>
> Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>

I wrote a similar patch a couple months ago, but they differ slightly,
maybe the code has changed somewhat:
http://marc.info/?l=git&m=118200193310898&w=2

--cc-nobody sounds better to me.

>                                 } elsif (/^(Cc|From):\s+(.*)$/) {
> -                                       if (unquote_rfc2047($2) eq $sender) {
> -                                               next if ($suppress_from);
> +                                       if (unquote_rfc2047($2)) {
> +                                               next if ($cc_nobody);
> +                                       }
> +                                       elsif (unquote_rfc2047($2) eq $sender) {
> +                                               next if ($suppress_from|$cc_nobody);
>                                         }
>                                         elsif ($1 eq 'From') {
>                                                 $author = unquote_rfc2047($2);

Here you could probably skip the whole branch if you check $cc_nobody
first of all.

> @@ -707,7 +715,7 @@ foreach my $t (@files) {
>                         }
>                 } else {
>                         $message .=  $_;
> -                       if (/^(Signed-off-by|Cc): (.*)$/i && $signed_off_cc) {
> +                       if (/^(Signed-off-by|Cc): (.*)$/i && $signed_off_cc && !$cc_nobody) {

Minor, but almost the same here.

Alex
