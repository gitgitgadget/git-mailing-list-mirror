From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/4] Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda
 conditions
Date: Tue, 3 Sep 2013 10:04:19 -0700
Message-ID: <20130903170419.GA29921@google.com>
References: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
 <1378103439-3225-4-git-send-email-felipe.contreras@gmail.com>
 <20130903071256.GD3608@sigill.intra.peff.net>
 <20130903075107.GA25540@goldbirke>
 <20130903080358.GA30158@sigill.intra.peff.net>
 <CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
 <20130903111006.GJ29840@goldbirke>
 <CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
 <20130903150855.GK29840@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Sep 03 19:04:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGu1t-0004n4-2z
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 19:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904Ab3ICREd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Sep 2013 13:04:33 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:52050 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522Ab3ICREc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 13:04:32 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so6721478pad.9
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Unpupau4X6iNwnBD2L+W+zExMHntkAlYoABhHCDCuhg=;
        b=G6ocBAXVkQbMPRLlLKhCVEUkTpNNySITAcb5D26txi+7Fsua+UkDEdDSFf5xSuuvJ5
         0fk+tHx4UFI+26kUhxs+vZyJR2AYauHbUwNNXBm6LtexpfWNhDsaruQaVRrmRnn6nloG
         ZdvBXz6QBxvuckPbr9GeuyFNU8sKFrPn16z8BX446oyVRvyaZdy0RLhbOvaPto6eGCdv
         yM+WcIlV+eASrZ1pdSbyrpRkXdx/Kan6O+V+TeO5E+f8f8Bvn1cI+gNifgrRXk55h7lt
         1AHOMTsKkV7QzjqkuAMHHXNbiKkThxSRKPFycbdnm/snInRv+sYuQ1I6E1JefuvleYgn
         aX1Q==
X-Received: by 10.68.219.33 with SMTP id pl1mr9880203pbc.147.1378227871832;
        Tue, 03 Sep 2013 10:04:31 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id sy2sm23570797pbc.16.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 03 Sep 2013 10:04:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130903150855.GK29840@goldbirke>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233736>

SZEDER G=E1bor wrote:
> On Tue, Sep 03, 2013 at 08:39:54AM -0500, Felipe Contreras wrote:

>> There are two ways to fix an inconsistency, the other way is to fix
>> test_cmp. But that would be a change, and change is not welcome in
>> Git.
>
> It depends on the change, I suppose.  I agree, changing 3k+ lines jus=
t
> to avoid yoda conditions...  I doubt the gain worth the code churn.

Especially when the idiom being changed is not even being made better.
;-)

test_cmp_rev follows the same order of arguments a "diff -u" and
produces the same output as plain "git diff".  It's perfectly readable
and normal.  I think Felipe is pushing buttons and testing boundaries.

But in the process came a report of a missing test_cmp_rev use, which
is useful.  Patch follows.

While at it, I rerolled the other patches from the series to clarify
their commit messages (replacing "fix <something>" with a fuller
description).

Improvements welcome, as always.  Thanks.

=46elipe Contreras (3):
  rev-parse test: modernize quoting and whitespace
  rev-parse test: use test_must_fail, not "if <command>; then false; fi=
"
  rev-parse test: use standard test functions for setup

Jonathan Nieder (1):
  rev-parse test: use test_cmp instead of "test" builtin

 t/t6101-rev-parse-parents.sh | 110 +++++++++++++++++++++++++++++++----=
--------
 1 file changed, 79 insertions(+), 31 deletions(-)
