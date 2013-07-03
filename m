From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH] t4205: don't rely on en_US.UTF-8 locale existing
Date: Thu, 4 Jul 2013 00:47:02 +0400
Message-ID: <20130703204702.GB6148@dell-note>
References: <f607decdc65b86b1759438e375ddf77fd5b91042.1372882590.git.john@keeping.me.uk>
 <20130703204024.GA6148@dell-note>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jul 03 22:47:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuTxM-0003Ah-JI
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 22:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876Ab3GCUrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 16:47:08 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:52765 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964864Ab3GCUrG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 16:47:06 -0400
Received: by mail-la0-f47.google.com with SMTP id fe20so567801lab.34
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 13:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=QAZB9fGSOlKnLYQEGG1UsBG5qmwMF96gQ2w0Ce3RScA=;
        b=Iv6IJREyo10zErMo6H0Q44taAW5WWbl9gfASDd6G3Y0d2DfSa1Bs8lojqDngtGX3k1
         G9Aq0X69wmceMNb7jiKA0LTrzM1z0iYQFgTOWZPMD+JttGk5gcPFZOhQYm51jKFaleo2
         emicA/mR6+TW/iopgByoX1ZTFTg3xxnsW0Juk/8PSYmHUjngP7KyjJ6L0IGLsVynkfHi
         +Q7Lz0gf6FiA3NEwjkmfcmvtpTGXxFTn3hzz4EUPTD08sZ6XUVjIlVKYHc2UuOc+c/J+
         1j9LhQ0QR9N562uLsz0yDpWkL3iEEM4H6g4cziXX2g5fnIKlbabUX4wPIGTYTihi2w2I
         48Yg==
X-Received: by 10.112.180.164 with SMTP id dp4mr2036106lbc.68.1372884424460;
        Wed, 03 Jul 2013 13:47:04 -0700 (PDT)
Received: from localhost (ppp91-77-20-80.pppoe.mtu-net.ru. [91.77.20.80])
        by mx.google.com with ESMTPSA id k10sm116289lbl.10.2013.07.03.13.47.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jul 2013 13:47:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130703204024.GA6148@dell-note>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229529>

http://thread.gmane.org/gmane.comp.version-control.git/229291

this is why CCed
> CC this to Johannes Sixt
> 
> On Wed, Jul 03, 2013 at 09:18:08PM +0100, John Keeping wrote:
> > My system doesn't have the en_US.UTF-8 locale (or plain en_US), which
> > causes t4205 to fail by counting bytes instead of UTF-8 codepoints.
> > 
> > Instead of using sed for this, use Perl which behaves predictably
> > whatever locale is in use.
> > 
> > Signed-off-by: John Keeping <john@keeping.me.uk>
> > ---
> > This patch is on top of 'as/log-output-encoding-in-user-format'.
> > 
> >  t/t4205-log-pretty-formats.sh | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> > index 3cfb744..5864f5b 100755
> > --- a/t/t4205-log-pretty-formats.sh
> > +++ b/t/t4205-log-pretty-formats.sh
> > @@ -20,9 +20,7 @@ commit_msg () {
> >  		# cut string, replace cut part with two dots
> >  		# $2 - chars count from the beginning of the string
> >  		# $3 - "trailing" chars
> > -		# LC_ALL is set to make `sed` interpret "." as a UTF-8 char not a byte
> > -		# as it does with C locale
> > -		msg=$(echo $msg | LC_ALL=en_US.UTF-8 sed -e "s/^\(.\{$2\}\)$3/\1../")
> > +		msg=$(echo $msg | "$PERL_PATH" -CIO -pe "s/^(.{$2})$3/\1../")
> >  	fi
> >  	echo $msg
> >  }
> > @@ -205,7 +203,7 @@ test_expect_success 'left alignment formatting with ltrunc' "
> >  ..sage two
> >  ..sage one
> >  add bar  Z
> > -$(commit_msg "" "0" ".\{11\}")
> > +$(commit_msg "" "0" ".{11}")
> >  EOF
> >  	test_cmp expected actual
> >  "
> > @@ -218,7 +216,7 @@ test_expect_success 'left alignment formatting with mtrunc' "
> >  mess.. two
> >  mess.. one
> >  add bar  Z
> > -$(commit_msg "" "4" ".\{11\}")
> > +$(commit_msg "" "4" ".{11}")
> >  EOF
> >  	test_cmp expected actual
> >  "
> > -- 
> > 1.8.3.1.747.g77f7d3a
> > 
