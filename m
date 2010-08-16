From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 07/12] bundle: run setup_git_directory_gently() sooner
Date: Mon, 16 Aug 2010 03:07:09 -0500
Message-ID: <20100816080709.GA17566@burratino>
References: <20100626192203.GA19973@burratino>
 <20100806023529.GB22369@burratino>
 <20100806031204.GK22369@burratino>
 <201008160921.33198.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Aug 16 10:08:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkukV-0003Aq-GU
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 10:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774Ab0HPIIq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Aug 2010 04:08:46 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46329 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab0HPIIp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Aug 2010 04:08:45 -0400
Received: by iwn7 with SMTP id 7so1436432iwn.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 01:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=KPFA3DMKZc4TVUHidU5se7cSHbrjBMo+n6oH7l5xj5w=;
        b=r/lqfz+3szBBDQuHvatCsRbRLjCZbpHjzS/kVNUmOMQUJfk0avK2tevJ7sKDUqwBBt
         BB01xSo9oXXCboAI/KuD34/TsBFLHwCoEUznKeFcN7ToM2uxC99hq8wvR9BHiz0kUPPr
         b82MTJJITObqprHrL1qWBJtS6R+kum4gqwHvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=cFQkb753FzCmdX6ZooNzEaQnuWajNUWnuPVMkai0XPwfzgQm4VCW1wrYccT4xg3/2z
         Q3GtzxzlC3oZfLY3d7dUeqqaTU+BfTDbPoPPuCe5UqWh/1Jtan2In2azMTZFA+SyiMKe
         +fAhdFacXEzXlUBm59JnANws8Bc8Uw6iJzyqk=
Received: by 10.231.146.134 with SMTP id h6mr5316147ibv.170.1281946124874;
        Mon, 16 Aug 2010 01:08:44 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id j2sm4396862iba.12.2010.08.16.01.08.43
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Aug 2010 01:08:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201008160921.33198.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153653>

On Mon, Aug 16, 2010 at 09:21:32AM +0200, Thomas Rast wrote:
> Jonathan Nieder wrote:

>> +test_expect_success 'configuration can enable pager (from subdir)' =
'
[...]
>> +		test_terminal git bundle unbundle ../test.bundle
[...]
> On my valgrind test setup, this never worked (i.e., fails and bisects
> to this commit).

Agh, sloppy me...  Fixes below.

> Oddly, I am seeing this error message from the second test (second in
> t7006, not in this patch):
[...]
>   Can't locate IO/Pty.pm in @INC (@INC contains: <snip>) at /local/ho=
me/trast/git/t/t7006/test-terminal.perl line 4.
>   BEGIN failed--compilation aborted at /local/home/trast/git/t/t7006/=
test-terminal.perl line 4.
>   ok 2 - set up terminal for tests
>=20
> Which raises a few questions: Why was this never an issue before?

That=E2=80=99s expected behavior, marked with =E2=80=9Cok=E2=80=9D. :) =
 That test is checking
if IO::Pty is available and works; if not, the relevant tests should
be skipped.

> does the test need a prerequisite other than HAVE_PERL?4

Exactly.

Jonathan Nieder (2):
  t7006 (pager): add missing TTY prerequisite
  t7006 (pager): add missing TTY prerequisite

 t/t7006-pager.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
