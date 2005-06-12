From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: [zooko@zooko.com: [Revctrl] colliding md5 hashes of human-meaningful documents]
Date: Sun, 12 Jun 2005 09:14:03 -0400
Message-ID: <118833cc050612061452f0eb3e@mail.gmail.com>
References: <20050612082555.GB6620@pasky.ji.cz>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 15:11:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhSFA-00076r-OD
	for gcvg-git@gmane.org; Sun, 12 Jun 2005 15:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVFLNPg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Jun 2005 09:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVFLNO0
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jun 2005 09:14:26 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:24270 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262476AbVFLNOG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2005 09:14:06 -0400
Received: by rproxy.gmail.com with SMTP id a41so1280016rng
        for <git@vger.kernel.org>; Sun, 12 Jun 2005 06:14:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jLCpp89QFfYRJB1hlzyepXoeb7mEqUWmo57jANgjYFPwGmnNW3Bxc5FdgnXCGcaRgPOG5YPb4E1Q2E/eZYlUbOfZpPDperuaAVL/pdt+MDLjiemhVXo+5FFib5oO1e2o/jg6Uyex52CGTVW+E0tqF0Jpa71y+8T43HWWYOF+vQA=
Received: by 10.38.24.21 with SMTP id 21mr513263rnx;
        Sun, 12 Jun 2005 06:14:03 -0700 (PDT)
Received: by 10.38.76.22 with HTTP; Sun, 12 Jun 2005 06:14:03 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050612082555.GB6620@pasky.ji.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I looked at this.

If you can find just *one* colliding pair that does not contain a
few select bytes like 0x22 (quote), 0x5c (backslash) and
perhaps 0x0a then it is trivial to make a colliding pair of
C programs.

Call the initial pair (A,B) and make the programs

/* Common prefix that happens to have integer block size
   ending just before the A below. */
const char junk[] = "AB";
/* "AA" in program 1, "AB" in program 2.  */
...
int
main ()
{
  int hsize = sizeof (junk) / 2;
  if (memcmp (junk, junk + hsize, hsize))
    return do_program_2 ();
  else
    return do_program_1 ();
}
