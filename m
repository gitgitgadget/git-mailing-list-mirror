From: Sam Vilain <sam@vilain.net>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Mon, 13 Feb 2006 17:40:22 +1300
Message-ID: <43F00DB6.4040306@vilain.net>
References: <20060210195914.GA1350@spearce.org> <43EFF3D0.4090701@vilain.net> <20060213032903.GA32121@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 13 05:41:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8VWH-00008b-Gp
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 05:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbWBMEkz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 23:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbWBMEkn
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 23:40:43 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:21919 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1751613AbWBMEkm (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2006 23:40:42 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 14A6E469A; Mon, 13 Feb 2006 17:40:38 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 767F64581;
	Mon, 13 Feb 2006 17:40:26 +1300 (NZDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060213032903.GA32121@spearce.org>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16043>

Shawn Pearce wrote:
>>>I just posted the first public version of pg, a GIT porcelain for
>>>managing patches.  Think StGIT, but better in some ways:
>>>Feature Summary:
>>>- Maximum compatibility with other GIT porcelains.
>>>- Simplified command line user interface.
>>How do I edit the description of an existing patch using pg?  Perhaps an
>>option to pg-push ?
> There isn't any description associated with a patch beyond its name
> (which can be changed with pg-rename).  Unlike StGIT pg currently
> doesn't store a description with each patch.
> This is partly because I want pg to extract the comments given to
> pg-ci to make the description of the patch during an export with
> pg-export - but I haven't written the code to walk back along the
> related commits and extract each comment.  On the other hand this
> might not be the best description for a patch.  :-)

ok.  Well, perhaps a nice solution might be just to aggregate the
comments as each new commit is made.  ie, the previous comment is
prepended to the new comment unless you use the editor or a special
-M (or whatever) option that replaces the running comment.

I tried importing a patchset into pg, and made some changes to it to see
the patch revisioning going on.  However, I can't see this happening.
Can you perhaps include this information in your tutorial?

As far as other, more general critiques of the software goes:  What
about merging?  stgit has a very nice way of merging; I specify how to
merge using a config file, and when I rebase my patches with "stg pull",
it fires up my custom editor.  All I really want is a way to specify how
to handle merges, with the ancestor/left/right files on hand.  I want to
use something as simple as this script:

#!/bin/sh

branch1="$1"
branch2="$2"
ancestor="$3"
output="$4"

echo "Merging:"
echo
echo "   $branch1"
echo " - $ancestor"
echo
echo " with:"
echo
echo "   $branch2"
echo " - $ancestor"
echo
echo " to: $output"
echo ""
echo -n "Trying diff3..."

if diff3 -L local -L older -L remote -m -E "$branch1" "$ancestor" \
    "$branch2" > "$output"
then
     echo "OK"
else
     echo "failed"
     echo "falling back to ediff-merge"
     emacs --eval "(ediff-merge-files-with-ancestor \"${branch1}\"
                    \"${branch2}\" \"${ancestor}\" nil \"${output}\")"
fi

Those commands I got from the default .stgitrc config.

That's all the features I'm really after.

Sam.
