From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Mon, 21 Aug 2006 10:07:36 -0400
Message-ID: <9e4733910608210707v67659a1co7b73e409e0d20132@mail.gmail.com>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
	 <Pine.LNX.4.64.0608172323520.11359@localhost.localdomain>
	 <9e4733910608180615q4895334bw57c55e59a4ac5482@mail.gmail.com>
	 <Pine.LNX.4.64.0608181057440.11359@localhost.localdomain>
	 <20060821070609.GC24054@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 21 16:08:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFARL-00085A-4g
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 16:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030448AbWHUOHi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 10:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030496AbWHUOHi
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 10:07:38 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:8884 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030448AbWHUOHh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 10:07:37 -0400
Received: by nz-out-0102.google.com with SMTP id 14so256033nzn
        for <git@vger.kernel.org>; Mon, 21 Aug 2006 07:07:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FXZH2wq8royj8c0VERH9UkDtEFzZcOQoX9DvwrIYHCOmii7oPnqH/sZ+3oH7s6+T+vtAP442R/MSoQsjLIhUIIB7uls1+d3yGyUnw3wfKSwvo+3Y86pwRc+5025S9puYEDPqHYn1V0FdHbwnmNN8dko/bQTq1+p1DddYvhgEd9c=
Received: by 10.64.193.8 with SMTP id q8mr5266586qbf;
        Mon, 21 Aug 2006 07:07:36 -0700 (PDT)
Received: by 10.65.133.17 with HTTP; Mon, 21 Aug 2006 07:07:36 -0700 (PDT)
To: "Shawn Pearce" <spearce@spearce.org>
In-Reply-To: <20060821070609.GC24054@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25795>

Mozilla CVS files have between 1 and 1700 deltas. The average is ten,
but the deviation is high. I believe less than 10 files have over 1000
deltas, they are all in the root directory and related to the build
process. Many files have no deltas, or because of CVS artifacts all of
the revisions are identical.

I am still IO bound. Random access IO is the problem, not stream IO. I
have to open and read 110,000 (5GB total) files. It takes about 2hrs
to do all of the IO. I'm not CPU bound yet but as we make things more
efficient, I am getting closer to being CPU bound.

Forking is not an option. It can takes days to fork 1M copies of an
app. I have used oprofile on parsecvs. It spends 60% of the time in
the kernel processing fork calls. Parsecvs runs for 6hrs on mozcvs and
dies without finishing.

I am back to working on the branch code. I'm over the cold I got from
my 2 yr old. It is slow going now. I am in the phase where the import
process runs without error 5-10 minutes and then dies from some
unusual branch case. I fix it up and try again. I am slowly
identifying and removing all the code in cvs2svn that puts the
branches and symbols into their own subdirectories.

-- 
Jon Smirl
jonsmirl@gmail.com
