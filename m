From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv6 01/16] test-lib: make test_expect_code a test command
Date: Mon, 4 Oct 2010 04:28:30 -0500
Message-ID: <20101004092830.GM24884@burratino>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-2-git-send-email-newren@gmail.com>
 <7vfwwmdbgl.fsf@alter.siamese.dyndns.org>
 <AANLkTinVvmJMEDhPcxa_CiOL2_RsYBdo-JywXi2gKeYp@mail.gmail.com>
 <20101004035007.GB24884@burratino>
 <AANLkTi=7mrROAhFxNmF_cmU2OKKNuhsdTUVpHT+4Jg-Y@mail.gmail.com>
 <20101004040623.GC24884@burratino>
 <AANLkTink3gPGVGXnO2j1cvfHShPG1Lq23eeY6m+7b1bK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 11:31:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2hOh-0002Vn-5P
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 11:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202Ab0JDJbq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 05:31:46 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42804 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061Ab0JDJbq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 05:31:46 -0400
Received: by iwn5 with SMTP id 5so6690702iwn.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 02:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=JWNchg+/JeBepy9jCjXEF7pmxSe/AcImo7Hhrhb0tI8=;
        b=vDN4FIK0rKIEx15PgyVTkep7/7KJxCkaN3hJKPbiF9dAn7skj00QqnUI0WWSghlu3E
         XSjpA3VKl7vPPpEn5yLtH/8LK1H6KroufDf7kjrUrEM7zTbzQbQ7WCtxddd/X7a6zBem
         cRjOtZGaSUSXAbZNaEpnkvC3hj/WQQRKga6Y8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=A0z5vWPy8aCbJ4qJnCCgvXXpeSyl42y4u44KlrZ7lG+l9je6hjR23mAeE7cmAhRFx7
         w+tHtUgMI4N21Eyq69XXfQFcF1qCf+lGbfbT6VSxzLj7F0Ez5EGp+zbMrXMz1Ll4GFIh
         BkNI8Ol90xfZ6Pzs+PMe1NF9H+h+PDvaj5bFQ=
Received: by 10.231.192.80 with SMTP id dp16mr9916690ibb.39.1286184705555;
        Mon, 04 Oct 2010 02:31:45 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id r3sm4762521ibk.7.2010.10.04.02.31.44
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 02:31:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTink3gPGVGXnO2j1cvfHShPG1Lq23eeY6m+7b1bK@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158018>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On the other hand I just tested git in a path called /tmp/\\"\\/git/t

I tried /tmp/test"git and tests other than t0000.5 seem to work fine.

> and found that every single one of our tests fail.

Every test script, not every test, right?

That's a makefile bug, I think: the bin-wrappers/% rule does not
sed-quote the working directory before passing it to sed.  After
working around that with GIT_TEST_OPTS=3D--with-dashes, tests are
running without trouble.

I don't think these edge cases are particularly important, but I
do think it's better to make sure code that takes care of the edge
cases when it's easy.
