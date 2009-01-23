From: Wincent Colaiuta <win@wincent.com>
Subject: RFC: git diff colorization idea
Date: Fri, 23 Jan 2009 01:00:27 +0100
Message-ID: <53497057-1ADE-4300-9F35-B218959606FE@wincent.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 23 01:02:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ9Ui-0000dB-FI
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 01:01:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755640AbZAWAAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 19:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755526AbZAWAAc
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 19:00:32 -0500
Received: from wincent1.inetu.net ([209.235.192.161]:40961 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755266AbZAWAAb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 19:00:31 -0500
Received: from cuzco.lan (139.pool85-53-3.dynamic.orange.es [85.53.3.139])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n0N00SWf010711
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Thu, 22 Jan 2009 19:00:29 -0500
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106805>

Hi,

Lately I've been wishing that Git's diff output were colorized in a  
way that combines the standard line-by-line colorizing with the word- 
by-word colorizing you get with --color-words.

Pictures speak louder than words, so here are some to show what I mean:

http://www.flickr.com/photos/wincent-colaiuta/sets/72157612877491482/

There you'll find:

1. A couple of sample hunks colorized in the current, standard way

2. The same hunks colorized with "--color-words"

3. The same hunks as they would be colorized if you could take the  
standard colorization (1) and augment it with per-word highlighting  
from (2)

(that last hunk would probably look better with a different regex  
defining what a "word" is; in reality all that happened was that  
"rename|" got added to the line, so there's no need to highlight more  
than that).

This is not a new idea; it's something that I find myself wanting due  
to experience with colorization available in a number of different  
diff viewers. Here are some more sample shots showing how different  
viewers do it, with varying degrees of prettiness/ugliness:

- Meld: http://meld.sourceforge.net/meld_file1.png

- kdiff: http://kdiff3.sourceforge.net/doc/letter_by_letter.png

- Apple FileMerge: http://homepage.mac.com/kelleherk/iblog/C711669388/E464913847/Media/compare_db_filemerge.jpg

No doubt there are others, but you get the idea.

Would people be interested in seeing this feature go in? I've already  
started snooping around diff.c seeing what would need to be done. From  
what I can tell it would require a new command-line switch (seeing as  
"--color" plus "--color-words" already means something), and probably  
two new customizable color slots (such as color.diff.new.word,  
color.diff.old.word).

The approach I was thinking of taking was just grabbing the diff_words  
info produced when --color-words is passed and using it to augment  
specialized versions of emit_line() and emit_add_line().

I'm also thinking that perhaps a per-character approach might be  
useful here instead of a per-word one (it would make that last hunk  
look better in the mock-up screenshot that I posted); if I go the per- 
character route then that suggests that "--color-chars" might be the  
right option name, and the color slots would then be  
color.diff.new.char and color.diff.old.char.

Any feedback or suggestions before I get in too deep?

Cheers,
Wincent
