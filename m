From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 43/43] refs: tests for db backend
Date: Mon, 05 Oct 2015 20:20:10 -0400
Organization: Twitter
Message-ID: <1444090810.7739.3.camel@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
	 <1443477738-32023-44-git-send-email-dturner@twopensource.com>
	 <20151003173930.GA25904@spirit>
	 <xmqqh9m5z224.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org,
	mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 02:22:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjFzS-0007u6-1a
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 02:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbbJFAUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 20:20:14 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:34832 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbbJFAUN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 20:20:13 -0400
Received: by qgt47 with SMTP id 47so164977391qgt.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 17:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=a6z1/53HhrWyERAnDDV5Ex6mSb4AOwcUIZzjTvCsq54=;
        b=bVVp2Q8pTPtCc+vJD+fNi75qwjy6+MfVAtzgXpvwCsTJfGZzPOBoOE4tuK1gEqDVMM
         saU5YkAJNADq+P276y4s3mzyNcuJjWlHoyzsuWK4ndS+QARRPbiYgH5I1oZK03pZtPSt
         TCrljiGkQgGiinbgWnqh98+UcHgjjxHnhiaPrgOWJRAEiKzyNHdiuqib0CrJ345fjwbP
         DyrTjh8QCsxipbloVeds6Txxsx83uC9azgIzj0z8/bx3DSXqTp6MohX+Fq4RqQY3ccCX
         W3/yC1oYM5NTp7o4l5XxOzHqZ16X5pJmOsil2nN0m3Zmvtpqre92yeFZLz/xl0Bbzqpb
         2ucQ==
X-Gm-Message-State: ALoCoQnCBbVjcVYCQvHRZd/1oX4zvJ/vDr4/d+W7UJeBotC8HWPi+/K+5S9BaZQMPENPBW8jCezv
X-Received: by 10.140.148.203 with SMTP id 194mr45480762qhu.102.1444090812473;
        Mon, 05 Oct 2015 17:20:12 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id g197sm12473863qhc.35.2015.10.05.17.20.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2015 17:20:11 -0700 (PDT)
In-Reply-To: <xmqqh9m5z224.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279106>

On Mon, 2015-10-05 at 09:56 -0700, Junio C Hamano wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> 
> > On Mon, Sep 28, 2015 at 06:02:18PM -0400, David Turner wrote:
> >> Add tests for the database backend.
> >> 
> >> Signed-off-by: David Turner <dturner@twopensource.com>
> >> ---
> >>  t/t1460-refs-be-db.sh        | 1103 ++++++++++++++++++++++++++++++++++++++++++
> >>  t/t1470-refs-be-db-reflog.sh |  353 ++++++++++++++
> >>  2 files changed, 1456 insertions(+)
> >>  create mode 100755 t/t1460-refs-be-db.sh
> >>  create mode 100755 t/t1470-refs-be-db-reflog.sh
> >
> > These break 'make test' on builds without the db backend. Maybe squash
> > in something like the following:
> >
> > diff --git a/t/t1460-refs-be-db.sh b/t/t1460-refs-be-db.sh
> > index f13b0f0..c8222ed 100755
> > --- a/t/t1460-refs-be-db.sh
> > +++ b/t/t1460-refs-be-db.sh
> > @@ -9,6 +9,11 @@ test_description='Test lmdb refs backend'
> >  TEST_NO_CREATE_REPO=1
> >  . ./test-lib.sh
> >  
> > +if ! test -e ../../test-refs-be-lmdb; then
> > +	skip_all="Skipping lmdb refs backend tests, lmdb backend not built"
> > +	test_done
> > +fi
> 
> The idea is sound, but $TRASH_DIRECTORY (i.e. $(cwd) there) is not
> necessarily two subdirectories down from the build repository root
> (cf. --root=<there> parameter to the test scripts), so you need to
> account for that.

will fix these, thanks Dennis and Junio.
