From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Reinstate the helpful message when `git pull --rebase` fails
Date: Fri, 09 Oct 2015 13:49:45 -0700
Message-ID: <xmqqoag7ojh2.fsf@gitster.mtv.corp.google.com>
References: <cover.1444336120.git.johannes.schindelin@gmx.de>
	<xmqq612grhg7.fsf@gitster.mtv.corp.google.com>
	<CACRoPnSPVMt+FtK6bwfa7Z3jBheTEkBnhU+B7qL8JrAsSmAmkQ@mail.gmail.com>
	<4a99ca8724b3604cbbec48d559e134fd@dscho.org>
	<d89d595a223508896db9303c901e7c30@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>,
	Brendan Forster <shiftkey@github.com>,
	Git List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 09 22:49:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zkec1-0005HJ-2m
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 22:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757497AbbJIUts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2015 16:49:48 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34051 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756630AbbJIUtr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2015 16:49:47 -0400
Received: by padhy16 with SMTP id hy16so95953264pad.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2015 13:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Q9Vb+BB7rR5K1hdFUAqMU4+6mY/Q39AJdHjobw2DpVs=;
        b=M1Geh29O80MhjkH6GCTy/Jnu8U7/F0sTx9lcH3tyM7mfB0GryCVAMlOAo78Yz04PyQ
         IXG5HtSBSXkaA2u6G1BOiRPHE/MeFLg9ELfrIjBXkA1yTYll32a9faiSJXGQL0/d0BfO
         HQT+zDomF2PNIpbpbGP8E5P0f0zVGQkS+T2GgKPvHmgkaKqFNASVDYPR0E5eJPVFDIHN
         sHtUXb3zBu2ljPL/j9el784w6m102S+x49xSzpV79mYIl+7RLxrKO4bvqxV7Ph5+ezs/
         c8Tk4AHcWu28PMkj87F3cUktNnpNqh90lnqWpD8lBJoxHppFkiNtsFryqY5xRIlg6jHI
         f3JA==
X-Received: by 10.68.211.68 with SMTP id na4mr17064748pbc.94.1444423786421;
        Fri, 09 Oct 2015 13:49:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:6d9f:e45b:5c65:e644])
        by smtp.gmail.com with ESMTPSA id kl11sm4129919pbd.67.2015.10.09.13.49.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Oct 2015 13:49:45 -0700 (PDT)
In-Reply-To: <d89d595a223508896db9303c901e7c30@dscho.org> (Johannes
	Schindelin's message of "Fri, 09 Oct 2015 12:11:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279317>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> I finally have that test case working, took way longer than I wanted to:

This certainly fails without any fix and passes either with your
two-patch or a more conservative run_command() fix that I sent
separately.

However, this new test (becomes 5520.20) seems to break the
precondition of some later tests---I didn't dig but 5520.22 (which
used to be .21) fails after letting this new test run and succeed.

> I think there is more than one fix necessary to truly address the
> issue: the underlying problem is that Git handles *committed*
> CR/LF really badly when the corresponding `.gitattributes` label
> the file as `text=auto`.

Yeah, that certainly is the right thing to tackle.
