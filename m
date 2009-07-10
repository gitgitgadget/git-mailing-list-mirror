From: Nicolas Pitre <nico@cam.org>
Subject: Re: [script] find largest pack objects
Date: Thu, 09 Jul 2009 23:34:26 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0907092332030.21547@xanadu.home>
References: <A67AA762-487D-4CFB-B555-718C88C5787D@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Antony Stubbs <antony.stubbs@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 05:34:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP6si-0003fv-0l
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 05:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbZGJDee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 23:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbZGJDee
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 23:34:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:44888 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbZGJDed (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 23:34:33 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KMJ00F0ER9FNRF0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 09 Jul 2009 23:34:27 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <A67AA762-487D-4CFB-B555-718C88C5787D@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123033>

On Fri, 10 Jul 2009, Antony Stubbs wrote:

> Blog post about git pruning history and finding large objects in your repo:
> http://stubbisms.wordpress.com/2009/07/10/git-script-to-show-largest-pack-objects-and-trim-your-waist-line/
> 
> This is a script I put together after migrating the Spring Modules project
> from CVS, using git-cvsimport (which I also had to patch, to get to work on OS
> X / MacPorts). I wrote it because I wanted to get rid of all the large jar
> files, and documentation etc, that had been put into source control. However,
> if _large files_ are deleted in the latest revision, then they can be hard to
> track down.
> 
> #!/bin/bash
> #set -x
> 
> # Shows you the largest objects in your repo's pack file.
> # Written for osx.
> #
> # @see
> http://stubbisms.wordpress.com/2009/07/10/git-script-to-show-largest-pack-objects-and-trim-your-waist-line/
> # @author Antony Stubbs
> 
> # set the internal field spereator to line break, so that we can iterate
> easily over the verify-pack output
> IFS=$'\n';
> 
> # list all objects including their size, sort by size, take top 10
> objects=`git verify-pack -v .git/objects/pack/pack-*.idx | grep -v chain |
> sort -k3nr | head`
> 
> echo "All sizes are in kB's. The pack column is the size of the object,
> compressed, inside the pack file."
> 
> output="size,pack,SHA,location"
> for y in $objects
> do
> 	# extract the size in bytes
> 	size=$((`echo $y | cut -f 5 -d ' '`/1024))
> 	# extract the compressed size in bytes
> 	compressedSize=$((`echo $y | cut -f 6 -d ' '`/1024))
> 	# extract the SHA
> 	sha=`echo $y | cut -f 1 -d ' '`
> 	# find the objects location in the repository tree
> 	other=`git rev-list --all --objects | grep $sha`
> 	#lineBreak=`echo -e "\n"`
> 	output="${output}\n${size},${compressedSize},${other}"
> done
> 
> echo -e $output | column -t -s ', '

This is certainly useful.  Mind submitting a patch adding this script to 
contrib/stats/ ?


Nicolas
