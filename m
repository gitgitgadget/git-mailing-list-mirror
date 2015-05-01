From: David Turner <dturner@twopensource.com>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Fri, 01 May 2015 10:29:15 -0700
Organization: Twitter
Message-ID: <1430501355.2806.2.camel@ubuntu>
References: <1430343059.14907.18.camel@ubuntu>
	 <20150429214817.GA2725@peff.net> <1430346576.14907.40.camel@ubuntu>
	 <20150429231150.GB3887@peff.net> <20150430003750.GA4258@peff.net>
	 <1430355983.14907.55.camel@ubuntu> <20150430011612.GA7530@peff.net>
	 <1430358345.14907.62.camel@ubuntu> <20150430033725.GB12361@peff.net>
	 <1430450954.22711.69.camel@ubuntu> <20150501053559.GA13393@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 01 19:29:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoEkd-0002Tk-Fv
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 19:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbbEAR3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 13:29:19 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36387 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbbEAR3S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 13:29:18 -0400
Received: by pdea3 with SMTP id a3so97826278pde.3
        for <git@vger.kernel.org>; Fri, 01 May 2015 10:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=ZuaVaCQ9cJejUuxb7qDMn6y9Hsvq1Wp7qb7s0Bh9mMs=;
        b=N9Jz/xU8i5d0kZ6OPfUqMITqqiZGBU1MMyCBeFLMyA/bwMnotm8fetRsrawVU/YXTb
         PfRplPXeFp9FC+cs0UkjXD5aRE6UczRcOuuoanm97I/qgBwHSCEczndgmjksvGsLXFYZ
         fCbSp/IVXXzFj4SDsP24BHZlDT4QU/eSthCaXVK2FLmUTrv7zZpmYL0ODolZK4CLi1r9
         pYP2hOIa07th/BKPiGfqZtv44/RgRM9VHQw0ERttug4v/epM16Ge4lnGSeia10B+9KZs
         Qv4rtVSBPMG92rMgYMFCHmr7FjAWWB3qJQnos1FmPIx2cgVPquRAn7YoBinW4DSWc2Ph
         J5bA==
X-Gm-Message-State: ALoCoQkn19FK/HFbYwfBBKJPt4M1q4O5m/02iRLeieBRrRB574D0AlZCG75lLtcNZ3iSSJYwyFWB
X-Received: by 10.68.223.165 with SMTP id qv5mr19834085pbc.82.1430501357738;
        Fri, 01 May 2015 10:29:17 -0700 (PDT)
Received: from [172.25.135.195] ([8.25.197.26])
        by mx.google.com with ESMTPSA id v5sm5398862pdo.29.2015.05.01.10.29.16
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2015 10:29:16 -0700 (PDT)
In-Reply-To: <20150501053559.GA13393@peff.net>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268162>

On Fri, 2015-05-01 at 01:36 -0400, Jeff King wrote:
> On Thu, Apr 30, 2015 at 08:29:14PM -0700, David Turner wrote:
> 
> > >   4. Return the last object we could resolve, as I described. So
> > [...]
> > 
> > Actually, I think 4 has an insurmountable problem.  Here's the case I'm
> > thinking of:
> > 
> > ln -s ..  morx
> > 
> > Imagine that we go to look up 'morx/fleem'.  Now morx is the "last
> > object we could resolve", but we don't know how much of our input has
> > been consumed at this point.  So consumers don't know that after they
> > exit the repo, they still need to find fleem next to it.
> 
> Yes, agreed (my list was written before Andreas brought up the idea of
> symlinks in the intermediate paths). I think to let the caller pick up
> where you left off, you would have to create a new string that has the
> "remainder" concatenated to it.

Since that new string does not exist in the object db, isn't that pretty
much proposal 3?  We could, in this case, provide a fake sha as well
("0"*40), to make it clear that the object does not exist.
