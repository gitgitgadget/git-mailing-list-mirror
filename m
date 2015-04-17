From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] fast-import: add options to enable/disable case folding
Date: Fri, 17 Apr 2015 15:57:05 -0400
Message-ID: <20150417195705.GA36902@flurp.local>
References: <xmqqoarclgnr.fsf@gitster.dls.corp.google.com>
 <1429271526-31234-1-git-send-email-mh@glandium.org>
 <55313B4B.3030106@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 17 21:57:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjCO6-0006pR-2n
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 21:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663AbbDQT5O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Apr 2015 15:57:14 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34823 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbbDQT5L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 15:57:11 -0400
Received: by igbyr2 with SMTP id yr2so20716710igb.0
        for <git@vger.kernel.org>; Fri, 17 Apr 2015 12:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jSLxNU6B9qcXALhJv8F+XQvc0/YimCAZ2vOlX4bNg20=;
        b=Cw2GkGLOTv75PZgyXvaqGxxz9QWc7utekrjUrGzSupq/I3tkA8toG5HWWNRKgP8Skv
         XBb46qLWWODe0poBUV5ew/TOW/Hj9/xtLv/OFiAU4Rm5siXnOdbthAqQAydvvZ7P8In8
         7U9qWsxvULL0TcUnJKR2oyrebYA2BvYxOitpu5xfaZukrgF4AYxVKa6hiJPur44sOEu0
         wOayaBIW8EhtNnnt5Wb0YYONqV/SDnbRB4SFn9XfBZa9jAVfrCtv63mrhNRCKAc2/LAo
         KPTM2ahlL1G9ZXvwcAxx/J9NApr8VG1pKKdNtaU8ubKIfVlIFvgmYuN5I//jKT9rwrX1
         Fmzw==
X-Received: by 10.50.20.233 with SMTP id q9mr5259707ige.9.1429300630976;
        Fri, 17 Apr 2015 12:57:10 -0700 (PDT)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id d10sm1806313igo.0.2015.04.17.12.57.10
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 Apr 2015 12:57:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55313B4B.3030106@web.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267384>

On Fri, Apr 17, 2015 at 06:56:43PM +0200, Torsten B=F6gershausen wrote:
> On 04/17/2015 01:52 PM, Mike Hommey wrote:
> > +test_expect_success 'V: default case folding with ignorecase=3Dtru=
e' '
> > +	git config core.ignorecase true &&
> > +	git fast-import <input &&
> > +	git ls-tree refs/heads/V >actual &&
> > +	git update-ref -d refs/heads/V &&
> > +	cat >expected <<\EOF &&
> > +100644 blob 78981922613b2afb6025042ff6bd878ac1994e85	a
> > +EOF
> > +	test_cmp expected actual'
> > +
> > +test_expect_success 'V: default case folding with ignorecase=3Dfal=
se' '
> > +	git config core.ignorecase false &&
> > +	git fast-import <input &&
> > +	git ls-tree refs/heads/V >actual &&
> > +	git update-ref -d refs/heads/V &&
> > +	cat >expected <<\EOF &&
> > +100644 blob 78981922613b2afb6025042ff6bd878ac1994e85	A
> > +EOF
> > +	test_cmp expected actual'
> > +
> > +test_expect_success 'V: forced case folding with ignorecase=3Dtrue=
' '
> > +	git config core.ignorecase true &&
> > +	git fast-import --fold-case <input &&
> > +	git ls-tree refs/heads/V >actual &&
> > +	git update-ref -d refs/heads/V &&
> > +	cat >expected <<\EOF &&
> > +100644 blob 78981922613b2afb6025042ff6bd878ac1994e85	a
> > +EOF
> > +	test_cmp expected actual'
>
> If you want to make it shorter (and try to avoid repetition):
> The forced true cases could be collected in a loop.
> (and the same for forced=3Dfalse)

I was also going to suggest squashing the repetition. Here's what I
had in mind:

--- >8 ---
test_foldcase() {
	ignore=3D$1 &&
	case "$2" in
	true) fold=3D--fold-case folded=3Dtrue ;;
	false) fold=3D--no-fold-case folded=3Dfalse ;;
	*) fold=3D folded=3D$ignore ;;
	esac &&
	case $folded in true) folded=3Da ;; false) folded=3DA ;; esac &&

	test_expect_success "V: case folding: ignorecase=3D$ignore${fold:+ $fo=
ld}" "
		git -c core.ignorecase=3D$ignore fast-import $fold <input &&
		git ls-tree refs/heads/V >actual &&
		git update-ref -d refs/heads/V &&
		cat >expect <<-EOF &&
		100644 blob 78981922613b2afb6025042ff6bd878ac1994e85	$folded
		EOF
		test_cmp expect actual
	"
}

for o in '' true false
do
	for c in true false
	do
		test_foldcase $c "$o"
	done
done
--- >8 ---

which outputs:

--- >8 ---
ok 176 - V: case folding: ignorecase=3Dtrue
ok 177 - V: case folding: ignorecase=3Dfalse
ok 178 - V: case folding: ignorecase=3Dtrue --fold-case
ok 179 - V: case folding: ignorecase=3Dfalse --fold-case
ok 180 - V: case folding: ignorecase=3Dtrue --no-fold-case
ok 181 - V: case folding: ignorecase=3Dfalse --no-fold-case
--- >8 ---
