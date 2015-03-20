From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH] t1700: make test pass with index-v4
Date: Fri, 20 Mar 2015 18:37:50 +0100
Message-ID: <20150320173750.GA6545@hank>
References: <1426864165-7334-1-git-send-email-t.gummerer@gmail.com>
 <xmqqsiczfuqa.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eSA8cGNsb3Vkc0BnbWFpbC5jb20+?=@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 18:38:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ0ru-0002ja-Ny
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 18:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbbCTRhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 13:37:54 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37420 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbbCTRhx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 13:37:53 -0400
Received: by wixw10 with SMTP id w10so27367048wix.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 10:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WSVMsfs0wyq6uwhAaVrzQsnxxG/VHd4wAM9sfxl66uA=;
        b=ciC3SgqTlguoTKAxesQ6W2Knzg8RRYrUgRONOgyN2gpfU+Ta5v7A8qas1vHn0TW2mP
         gR/EXgQOmPdtR+GuciFnT6ghRKWCQyMjNlYZnv1UDjiMfpzK6CC/RtQjJufKBzIUO8Sp
         kdJC86LvGAqBsgEcTWdG3qaOaBVUAQRMf0d7OKmFL2613/KHRpropceDnbWgVn1X7Psu
         +LaWDpwMKDcfuvzwiJ1TcTRaUDNTcy5y6iLhkUUcJ0CzzrokDQ3gFRqDjw4wTaxJJZHe
         3GgUBYv6DAD+cBld8mn7F6Bg3EoeEe8IygwG0ftVqJpSclgFdCzDC+9VSvpo8pAFpROi
         Ephw==
X-Received: by 10.194.200.229 with SMTP id jv5mr165195670wjc.59.1426873072732;
        Fri, 20 Mar 2015 10:37:52 -0700 (PDT)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id q6sm3927519wix.3.2015.03.20.10.37.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2015 10:37:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqsiczfuqa.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265917>

On 03/20, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
> > The different index versions have different sha-1 checksums.  Those
> > checksums are checked in t1700, which makes it fail when run with index
> > v4.  Fix it.
>
> I am more interested to see how you managed to use index v4 in the
> tests be described next to "when run with index v4".  I thought we
> were controling these things fairly tightly (e.g. we disable hooks,
> move $HOME to avoid getting affected by your personal settings,
> etc.).

The tests can be run with index-v4 by setting TEST_GIT_INDEX_VERSION
in config.mak.  This configuration was introduced in 5d9fc88 test-lib:
allow setting the index format version.

> Thanks.
>
>
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  t/t1700-split-index.sh | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> > index 94fb473..92f7298 100755
> > --- a/t/t1700-split-index.sh
> > +++ b/t/t1700-split-index.sh
> > @@ -10,9 +10,18 @@ sane_unset GIT_TEST_SPLIT_INDEX
> >  test_expect_success 'enable split index' '
> >  	git update-index --split-index &&
> >  	test-dump-split-index .git/index >actual &&
> > +	indexversion=$(test-index-version <.git/index) &&
> > +	if test "$indexversion" = "4"
> > +	then
> > +		own=432ef4b63f32193984f339431fd50ca796493569
> > +		base=508851a7f0dfa8691e9f69c7f055865389012491
> > +	else
> > +		own=8299b0bcd1ac364e5f1d7768efb62fa2da79a339
> > +		base=39d890139ee5356c7ef572216cebcd27aa41f9df
> > +	fi &&
> >  	cat >expect <<EOF &&
> > -own 8299b0bcd1ac364e5f1d7768efb62fa2da79a339
> > -base 39d890139ee5356c7ef572216cebcd27aa41f9df
> > +own $own
> > +base $base
> >  replacements:
> >  deletions:
> >  EOF
> > @@ -30,7 +39,7 @@ EOF
> >
> >  	test-dump-split-index .git/index | sed "/^own/d" >actual &&
> >  	cat >expect <<EOF &&
> > -base 39d890139ee5356c7ef572216cebcd27aa41f9df
> > +base $base
> >  100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
> >  replacements:
> >  deletions:

--
Thomas Gummerer
