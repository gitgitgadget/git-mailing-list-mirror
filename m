From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Sun, 14 Oct 2007 12:25:27 -0700
Message-ID: <47126D27.4060409@midwinter.com>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com> <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail.com> <Pine.LNX.4.64.0710130130380.25221@racer.site> <853awepyz6.fsf@lola.goethe.zz> <20071013202713.GA2467@fieldses.org> <Pine.LNX.4.64.0710140135020.25221@racer.site> <alpine.LFD.0.999.0710131810550.6887@woody.linux-foundation.org> <20071014014445.GN27899@spearce.org> <3f4fd2640710140320h5c1e1f7gf9f43a626aaa6897@mail.gmail.com> <47125BF7.2070503@midwinter.com> <20071014184050.GB31260@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Reece Dunn <msclrhd@googlemail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sun Oct 14 21:25:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih95r-0004MM-VT
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 21:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbXJNTZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 15:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753158AbXJNTZb
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 15:25:31 -0400
Received: from tater.midwinter.com ([216.32.86.90]:50248 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752356AbXJNTZa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 15:25:30 -0400
Received: (qmail 16002 invoked from network); 14 Oct 2007 19:25:30 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=WqVd75gRhOGyBRqkwsE5uDekK9YfMIO0f0DXK6j0TeDm38OebHbgiUJ1kqZo+4iM  ;
Received: from localhost (HELO sgrimm-mbp.lan) (koreth@127.0.0.1)
  by localhost with SMTP; 14 Oct 2007 19:25:29 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <20071014184050.GB31260@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60894>

J. Bruce Fields wrote:
> I'm lost--how is "hg pull" different from "git pull" in this respect?
>   

(Pedantry alert: "hg pull" is equivalent to "git fetch" and doesn't 
update the working copy. I'll talk here about the "hg pull; hg update" 
pair which seems to be standard procedure in hg land.)

Here's a simple example in each system to demonstrate the difference.

---
 mkdir parent
 cd parent
 git init
 echo 'my baloney has a first name' > song.txt
 echo "it's o-s-c-a-r" >> song.txt
 echo 'my baloney has a last name' >> song.txt
 git add song.txt
 git commit -m "test file"
 cd ..
 git clone parent child
 cd parent
 echo "it's m-a-y-e-r" >> song.txt
 git commit -a -m "another line in the song"
 cd ../child
 perl -pi -e 's/first name/given name/' song.txt
 git pull
---

Result: "fatal: Entry 'song.txt not uptodate. Cannot merge."

---
 mkdir hgparent
 cd hgparent
 hg init
 echo 'my baloney has a first name' > song.txt
 echo "it's o-s-c-a-r" >> song.txt
 echo 'my baloney has a last name' >> song.txt
 hg add song.txt
 hg commit -m "test file"
 cd ..
 hg clone hgparent hgchild
 cd hgparent
 echo "it's m-a-y-e-r" >> song.txt
 hg commit -m "another line in the song"
 cd ../hgchild
 perl -pi -e 's/first name/given name/' song.txt
 hg pull
 hg update
---

Result: "0 files updated, 1 files merged, 0 files removed, 0 files 
unresolved" and the file contains the change from the parent plus the 
change from the child, with the latter still an uncommitted edit that 
shows up in "hg diff".

-Steve
