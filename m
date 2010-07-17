From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 4/4] Add interactive mode to git-shell for
 user-friendliness
Date: Sat, 17 Jul 2010 00:52:57 -0500
Message-ID: <20100717055257.GB29290@burratino>
References: <1279076475-27730-1-git-send-email-gdb@mit.edu>
 <4C3DC2BD.6020907@digium.com>
 <20100714152444.GA26674@pcpool00.mathematik.uni-freiburg.de>
 <201007141740.37867.trast@student.ethz.ch>
 <20100714160730.GA27078@pcpool00.mathematik.uni-freiburg.de>
 <AANLkTikEjMeKPkyY4RdRq-ESkmmq4PvqCFPgp8yvLVBz@mail.gmail.com>
 <AANLkTikiOgV1iE7dwPUkLpWTb_zXSFdEuOYvyqJ1eDCo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Bernhard R. Link" <brlink@debian.org>,
	Thomas Rast <trast@student.ethz.ch>,
	"Kevin P. Fleming" <kpfleming@digium.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Sat Jul 17 07:53:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oa0LW-0003B7-Ks
	for gcvg-git-2@lo.gmane.org; Sat, 17 Jul 2010 07:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076Ab0GQFxy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Jul 2010 01:53:54 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47874 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab0GQFxx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jul 2010 01:53:53 -0400
Received: by iwn7 with SMTP id 7so2855402iwn.19
        for <git@vger.kernel.org>; Fri, 16 Jul 2010 22:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=mv4tdM7XVCIZsxQ40U2nIQeBNPR7ttOhlLV2pva3f5M=;
        b=GV0BgwDdIPVgXgmvWu8UODVh9szhdaWexOLzGs+gvJVlSJBjotn8aXqruV+53TkahP
         AvOvg969YD7qbuPq+pAAZdg1l9osBeaumJMe/yGpbbAhlZ1bhdMIimaMpVmIVW/G4KUH
         jmooO3nMtqHi7bwHDZ5/onJiS8iMoLnAyQcqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ps9bXa9ub7xgeFZW5NBzNhc74SLaTPsOD9Eu2jpfxUFLFAabHSyxbM6xJeX8SVZ3l2
         tf4ASQkxmXVmBvafY6wLLb+lBNLfpQVOyv2ZAxiX4IQX8Ui8jwlbo1XY7b8T9vbCm3tg
         ifpDSjDuMCXYzD3FyTJeAAb5w0A5BvYW1ThEs=
Received: by 10.231.146.134 with SMTP id h6mr2020166ibv.170.1279346031642;
        Fri, 16 Jul 2010 22:53:51 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r3sm13168552ibk.19.2010.07.16.22.53.50
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 16 Jul 2010 22:53:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikiOgV1iE7dwPUkLpWTb_zXSFdEuOYvyqJ1eDCo@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151179>

Hi Greg,

Greg Brockman wrote:

> - Extend run_command to optionally use execv.  Would any other code
> actually want this functionality though?  If not, it's probably an
> excessively large code change for little benefit.

Of the options you presented, this is the best one.  It doesn=E2=80=99t=
 matter
whether any other code would use it; even if you are the only caller,
it is still good because

 - if someone else needs the facility, it will be obvious where
   to find it

 - you can share the existing logic to portably run a command
   (i.e., near free portability to msys).

run_command() already takes an argument for options like
RUN_USING_SHELL; your new facility would fit right in.

But first a more basic question: why not just add =E2=80=9C./=E2=80=9D =
to the start of
the command name?
