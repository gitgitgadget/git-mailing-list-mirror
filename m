From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH] test-lib.sh: work around ksh's trap shortcomings
Date: Wed, 20 Aug 2008 12:36:06 +0100
Message-ID: <e2b179460808200436p1c35da29h5e895f44346df80d@mail.gmail.com>
References: <giNXZFTxzY3B65dQob7CwvwwfSKlZpw_60oz81RxU5UN3PsTT_3dMQ@cipher.nrlssc.navy.mil>
	 <gPlIc7E6mNDrXE6mwaHXFoin7rDpLmjvuzlhJfCp-YmuyVK3pEzqNA@cipher.nrlssc.navy.mil>
	 <7vbpzplw9o.fsf@gitster.siamese.dyndns.org>
	 <cqiOMMbzSSjqZoLDEa5uscl2d0D71PrGu2TpSOULLuV5nTVnEEWCzQ@cipher.nrlssc.navy.mil>
	 <nEEUmh6BVMDYtwf1vENCYuaLiFUWKW_dbgPP__ECl3s@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Aug 20 13:38:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVm03-0000SM-FC
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 13:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbYHTLgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 07:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752776AbYHTLgJ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 07:36:09 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:4300 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787AbYHTLgI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 07:36:08 -0400
Received: by rv-out-0506.google.com with SMTP id k40so415606rvb.1
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 04:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=9hBgSaugeGxZLDCW+OM86eFMgJAMYigrMID8XtiAwow=;
        b=YPyPtLCR3R1HFPmetn9E5QeyURBg8pzxywZN0dJi8c1FrhvFgJ2FSSeoOO9tUqiedU
         liFewgPy+beDGqI++nrhYyWo8IUtoi/vE3C1bXfwyBywIZ9NQCGzfI1e5Yhx3LLjCkKO
         41/yYAXrJa2FvqNrLbC5kCbRihRJ0fzqIcjhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=lpNNxpsARvorSJ31Utc/2WwarqAZgaTgTOpxBrLda5PzZBUKi9YrOSiefVje77DJod
         OQ2p4GW6UOta/Bxu3usqSuqGAZqPaGy3jAtoDhXb2OsatF6XDNiZMjJB6Vbqp2TcBZWK
         6f4qk+KTQgRJGaxIDm1vDPfFCVC6lSWstn+sc=
Received: by 10.140.126.14 with SMTP id y14mr151rvc.160.1219232166560;
        Wed, 20 Aug 2008 04:36:06 -0700 (PDT)
Received: by 10.141.19.11 with HTTP; Wed, 20 Aug 2008 04:36:06 -0700 (PDT)
In-Reply-To: <nEEUmh6BVMDYtwf1vENCYuaLiFUWKW_dbgPP__ECl3s@cipher.nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92981>

2008/8/20 Brandon Casey <casey@nrlssc.navy.mil>
>
> Brandon Casey wrote:
> > Junio C Hamano wrote:
> >> Your alias test_done that calls function test_done look ugly and confusing
> >> beyond words.  Perhaps test_done() can instead set a global variable and
> >> die() can notice it instead, like this?  I haven't bothered to change the
> >> other "trap - exit" but I think you got the idea...
> >
> > Yes that works and is much clearer. Tested on solaris and irix.
>
> I spoke too soon. Failing tests do not terminate the testing.
>
> ksh does not place the exit status of the shell in $? or provide it as an argument
> to the trap function. ...  it looks like the status of the command executed immediately before
> exit is what the trap has access to in $?. Adding a call to false before exit
> in the above script causes the korn scripts to exit with status 1 on IRIX and
> SunOS.

Just to report the same findings with AIX 5.3's /bin/sh (which is
/bin/ksh), /bin/ksh93 and even /bin/bsh

Mike
