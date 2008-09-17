From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: [PATCH] Teach git diff about Objective-C syntax
Date: Thu, 18 Sep 2008 00:30:08 +0100
Message-ID: <57518fd10809171630v97485aalcc5089f96082c0fc@mail.gmail.com>
References: <57518fd10809170526i5c1e7dadgc38bb00e8073ba55@mail.gmail.com>
	 <1221658141-75698-1-git-send-email-jon.delStrother@bestbefore.tv>
	 <48D11C3C.5070707@op5.se>
	 <57518fd10809170831x6d84aeb0m9b0b2c4095a1de70@mail.gmail.com>
	 <20080917155505.GH4829@genesis.frugalware.org>
	 <57518fd10809171214u3b5b3b96yc432c1c410faf8b4@mail.gmail.com>
	 <7vljxq4i5p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@frugalware.org>,
	"Andreas Ericsson" <ae@op5.se>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 01:31:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg6UR-0007PS-0B
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 01:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbYIQXaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 19:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbYIQXaK
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 19:30:10 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:36123 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbYIQXaI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 19:30:08 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3244440wfd.4
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 16:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=VXSZdysEQVaptVNNFfGX3+kLMa+4IXyOOyXOE/Xrv8M=;
        b=iGbOl7QBCQ0sr7CcvhPecZCXM1FTw4PfYPMEf4CZoANJixlNAQ2y3kPoWhNJsWcXP+
         xt4Cd/IcY6302nLZOyigw/VMOY5Y67u+OKkEOOihq+qa9YKmKbluF+4kN5p2IGAnf75U
         qoQzRokAUozzaZxgN4tQVllUSvfIxNuHqNmL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=WrUVQiYizlU7smompcXzxeVQ73Jb5AeYo6ftnnQq8uOkVBl++/rBPymdiONHoYC6Bm
         2QuJT045bUh1iIndXx1bQXvK5tEU8HAQajjYKxCaCsv8MKLopYFxtiGWQwDns2GQNDA/
         PQeEM4L1VogBK/Fx157mi000CU+ldUQQz4bpo=
Received: by 10.143.5.7 with SMTP id h7mr1111305wfi.319.1221694208119;
        Wed, 17 Sep 2008 16:30:08 -0700 (PDT)
Received: by 10.143.6.3 with HTTP; Wed, 17 Sep 2008 16:30:08 -0700 (PDT)
In-Reply-To: <7vljxq4i5p.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 35b137c63d9a9012
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96151>

On Wed, Sep 17, 2008 at 9:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Are you sure the regexp you have for Objective-C methods quotes a dot "."
> correctly, by the way?  It appears to match almost anything enclosed in a
> pair of parentheses, as long as you have two alpha after open paren.

It could be a little more restrictive, but I'm not sure how much
further it could be taken without it getting ridiculous.  Just as some
examples, it needs to match :
+(id)someClassMethod
-(id)someInstanceMethod
-(NSNumber*)numberWithNumerator:(int)n denominator:(int)d
-(NSString*)stringWithVariableArguments:(NSString*)format ...

(I seem to remember that if your method returns 'id' you can skip the
return type, eg "- someInstanceMethod", but I don't think there's any
hope for people that use that notation...)

^[ \t]*\\([-+][ \t]*([ \t]*[A-Za-z_][A-Za-z_0-9* \t]*)[ \t]*_?[A-Za-z]*\\)$
would be a small improvement - that is, a plus or minus, brackets
around the return type, then at least one letter for the method name,
potentially preceded by an underscore.  Can anyone suggest anything
better?

Also, why can't I use \s for whitespace, \w for word characters etc?
I thought we were using the gnu regex library?


> Also I am not sure if you can do the pattern alternates the way you did.
> If you have this:
>
>        "...\\(A\\|B\\)$"
>        "\\|"
>        "...\\(C\\|D\\)$"
>
> A and B will be captured as $1 but wouldn't C or D captured as $2?

Hmm, hadn't considered that.  It appears to work fine, but I haven't
yet had chance to track down exactly where the funcname regexp match
occurs to see what the code is doing with the different matches.  I'll
try and take a look tomorrow, unless someone can enlighten me before
then...
