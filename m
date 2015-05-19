From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2] pull: handle --log=<n>
Date: Tue, 19 May 2015 23:49:27 +0200
Message-ID: <1432072167.14498.12.camel@kaarsemaker.net>
References: <1431956396-21788-1-git-send-email-pyokagan@gmail.com>
	 <5661061272076a1883cfde1087be4a42@www.dscho.org>
	 <xmqq617pda0r.fsf@gitster.dls.corp.google.com>
	 <6b905c01c9b57abc05fb49117c28c10e@www.dscho.org>
	 <CAPc5daVze4+8aLGPpZgxDnvKSwvQiaR=kRdwfAHXFYA7HChmMg@mail.gmail.com>
	 <1432070690.14498.4.camel@kaarsemaker.net>
	 <xmqqfv6s6ygb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 19 23:49:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YupOK-0002gk-HS
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 23:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbbESVtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 17:49:32 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38008 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbbESVtb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 17:49:31 -0400
Received: by wichy4 with SMTP id hy4so38535488wic.1
        for <git@vger.kernel.org>; Tue, 19 May 2015 14:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=rvEVi0LvBCwFeuYsfPkZdBim/bUuaD4IJ5p2GEehHsg=;
        b=RWGzEQaweyTBw1Xldi4PqbVl/3CFn4HPeMc6V+ROnoRtn68Njd+cSE/KW8LrM75KsM
         c3uJ5Qmi3Pdq/Dg3nqiE3XL8vqQEYyUvTwp9NrY3dCTGVrmsk5NW19Rc7OWW+hpceK8T
         Z2PzCU6NrCbu8mohvB3K9hgDP67xq2EXY6sX4j7wXv6VFI6i2ghC1bahh1QJUgCkWQGA
         HiuQJrMrKXisNwI1VLJjI0mltWHfRe/lTX/qA3iiRvlf/BJpAjyRmFplDRpz50Mi9vx3
         F2w/HlnILUrUG45XXWHsExTHV0rDcCdAZItonFuspMMWHCzGzgDE2W1nhJ5WM99DDe5X
         xU+g==
X-Gm-Message-State: ALoCoQnXk8MhobLUqGaIFM/16zm+oexO56RFPP5RNAGsXa5jOqeea+u74CKvfs/Ua/BhEtmjuk9P
X-Received: by 10.180.91.76 with SMTP id cc12mr36361031wib.67.1432072170096;
        Tue, 19 May 2015 14:49:30 -0700 (PDT)
Received: from spirit.home.kaarsemaker.net (82-171-80-33.ip.telfort.nl. [82.171.80.33])
        by mx.google.com with ESMTPSA id ng5sm227481wic.24.2015.05.19.14.49.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2015 14:49:29 -0700 (PDT)
In-Reply-To: <xmqqfv6s6ygb.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269412>

On di, 2015-05-19 at 14:37 -0700, Junio C Hamano wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> 
> > I took a stab at this, adding a --tag option to test_commit and adding
> > the option to the test_commit calls that need it (or removing tests'
> > reliance on these tags where appropriate, or removing tests' workarounds
> > for dealing with these tags when they don't want them), and the result
> > is 59 files changed, 280 insertions(+), 281 deletions(-)
> >
> > A test run on master with GIT_TEST_LONG set causes 1138 calls to
> > test_commit on my system, of which 255 now use the --tag option
> > (measured with a really crude hack that INCR's some keys in redis at
> > appropriate points in test_commit).
> >
> > Is this interesting enough to turn into a proper patch series?
> 
> Wow.
> 
> A proper patch series would probably be
> 
>  [1/N]   Teach "test_commit --tag" and replace existing "test_commit"
>          with "test_commit --tag"
> 
>  [2-N/N] For all the test scripts, analyse and judge if they are
>          better off with the auto-generated tags (i.e. no change wrt
>          the result of 1/N) or tags that are created by the script
>          at strategic places only as needed, and convert those that
>          are better read without "test_commit --tag".
> 
> [1/N] would be mechanical and easy, but justifying the change in the
> remainder would be a lot of work and reviewing would be, too, and
> would require a good taste.

I've actually done it differently while implementing:

1) Make test_commit recognize --tags and stop creating tags unless
   specified
2) while ! prove --state=save,failed {
       Find and fix tests that now need --tags
   }

For the actual patch series I'll add -p the changes slightly
differently:

1/N: Make test_commit recognize a --tags parameter but not change
behaviour.
2/N - N-1/N: Add --tags where necesary (or other fixes as appropriate)
N/N: Only write tags when --tags is passed to test_commit.

That way 'make test' will pass at every step.

> Perhaps if we see two sample patches to see how it looks like, would
> that help us decide?
> 
> That is, the mechanical [1/N] and [2/N] for one of the test script
> that can do without --tag, and a sample "do not apply" patch to show
> "if we change 'test_commit --tag' to 'test_commit', the script t1234
> needs this many manual tagging by the caller, and it is not worth
> doing"?  I dunno.

I'll just send an entire patch series. It's not that much more work.

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
