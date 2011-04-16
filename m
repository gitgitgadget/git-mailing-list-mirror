From: madmarcos <fru574@my.utsa.edu>
Subject: Java Inflater problem decompressing packfile
Date: Fri, 15 Apr 2011 19:05:05 -0700 (PDT)
Message-ID: <1302919505984-6278154.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 04:05:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAutA-0004we-F4
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 04:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756827Ab1DPCFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 22:05:07 -0400
Received: from sam.nabble.com ([216.139.236.26]:43392 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756750Ab1DPCFG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 22:05:06 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <fru574@my.utsa.edu>)
	id 1QAusj-0005EI-Vy
	for git@vger.kernel.org; Fri, 15 Apr 2011 19:05:05 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171656>

This may be better suited for the Java forums but I will ask it here just in
case someone has run into it before.

I have a packfile that I have saved as a file from the git-upload-pack
command. I want to read through the packfile, decompressing each of the
objects. 

My little inflater procedure works fine for a tiny HelloWorld project. So, I
decided to mix it up a little and use the jEdit source for a larger test. I
am 99% certain the jEdit.git packfile itself is ok as I have passed it
through directly to eGit's Import using an SSH proxy and eGit unpacked it
just fine.

So, my inflater method decompresses the first 7 objects fine (a commit, a
couple of trees, and several blobs) and a cursory visual inspection of the
decompressed data seems fine. The eighth object becomes a problem, though.
It is a blob with the name build.xml that is 51,060 bytes decompressed
(looking at the original pre-git-pushed jEdit source). The actual file size
matches the decompressed data content size in the packfile object header. 
The inflater procedure outputs the decompressed data to System.out for
visual inspection. Approximately the first 1/3 looks like the original
build.xml but after that, the output is garbled. The procedure continues
decompressing objects after the 8th, but garbled, object but it dies on the
9th object with an "unknown compression method" error.

So I created a new test inflater to focus only on decompressing the 8th
object. Simply opening the packfile, copying out the compressed data (7793
bytes), and inflating it yields the same 2/3 garbled xml. 

As a further test, I then take the original build.xml file, compress it
using java's Deflater (yielding a 7793 byte array), and then inflate it
using my same procedure and it decompresses fine. All of the xml is
readable.

Now, I have tried several variations of an inflater procedure, including an
patchwork variation from jGit's WindowCursor.inflate method. But they all
yield the same garbled result for the compressed build.xml data.

Any suggestions. I can post some of my ugly code if asked.

Thanks!

--
View this message in context: http://git.661346.n2.nabble.com/Java-Inflater-problem-decompressing-packfile-tp6278154p6278154.html
Sent from the git mailing list archive at Nabble.com.
