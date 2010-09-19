From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: Find out on which branch a commit was originally made
Date: Mon, 20 Sep 2010 01:12:05 +0200
Message-ID: <4C9698C5.70607@gmail.com>
References: <1jp0h7e.lgk0kp19qe5bbM%lists@haller-berlin.de> <201009192030.21659.robin.rosenberg@dewire.com> <201009192203.o8JM39PE011067@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Mon Sep 20 01:12:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxT3g-00048w-HT
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 01:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777Ab0ISXML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Sep 2010 19:12:11 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42766 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656Ab0ISXMK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 19:12:10 -0400
Received: by ewy23 with SMTP id 23so1431909ewy.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 16:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        bh=Ac5HYlZvVi4KX5NYiuThUqmu3fiMW49kfDxDED5ZOAc=;
        b=bRiJmDExsacGOpMPmQYmcG/xyi6FqLM3jTIIk1+bwo83Q5wF1SaQVe1Li3MoUy3gu6
         YJfrSgRaA0a6Pj5cOaxgxtNd9UfwKfigQNiHRkFVTEj/LA0Fb/OPECdgoibzwjEB1kTf
         yZkTdr1kqVZPaJkwY1ME+FC2S8HXnXszTZ89k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:openpgp:content-type
         :content-transfer-encoding;
        b=uagjBxV6/ZzIR+QDyaucD4tDu+Vk8AmfMnuVKlu0U0WPhubuLVrxMKZC7YyysezRrI
         gc0cZ9TcmcemrEU3aDyoDcp7lLSelbCa1ds47icS9iD0YRv43NjGrmBM8VRsUH91ms70
         QPnE70Wffy95khbCcOLYDQXBFuXThsXlHtXLM=
Received: by 10.213.19.78 with SMTP id z14mr2109556eba.66.1284937928842;
        Sun, 19 Sep 2010 16:12:08 -0700 (PDT)
Received: from [172.19.43.221] (ip-89-174-125-70.multimo.pl [89.174.125.70])
        by mx.google.com with ESMTPS id u9sm9943284eeh.5.2010.09.19.16.12.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 16:12:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.9pre) Gecko/20100819 Lightning/1.0b2 Lanikai/3.1.3pre
In-Reply-To: <201009192203.o8JM39PE011067@no.baka.org>
X-Enigmail-Version: 1.1.1
OpenPGP: id=DDEB1C43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156520>

On 09/20/10 00:03, Seth Robertson wrote:
>>>>                A---B---C topic
>>>>               /         \
>>>>          D---E---F---G---H---I---J---K---L---M---N master
>>>>                                   \         /
>>>>                                    O---P---Q another-topic
> 
>>> No, that's not what I need either.  After thinking about it more, I
>>> think what I want is "of all merges in the ancestry path from B to
>>> master, show only those whose first parent can't reach B."  The result
>>> is the list of all merges that were involved in bringing B to master.
> 
> 
>> This would work, and i don't see a way to optimize it in git-speak,
>> given that you don't want to see any extra trailing merges. [...]
> 
> The provided command actually doesn't work for me for all cases.  It
> works for the simple case of "B", but does not work for "F", because F
> saw merge H & M.  I think we need --not --first-parent, except that

Well, F was never on a separate branch, so the command returning ""
is arguably the right thing.
The example I gave
(B->[merge of subtopic]->[merged to supertopic]->[merged to master])
was the case where "--not-first-parent" wouldn't help, even if such
an option would exist.

> doesn't actually work in this case either.  However, if we get the
> full --first-parent rev-list and look for our commit, that works.
> This is incredibly painful, though.
> ----------------------------------------------------------------------
> #!/bin/sh
> TARGET=`git rev-list -n 1 $1`
> git branch -a --contains $1 | sed 's/^\** *//' | grep -v ' -> ' |
> while read br; do
>  if git rev-list --first-parent $br | grep -q "$TARGET"; then
>   echo $br
>  fi
> done
> ----------------------------------------------------------------------

And it does not work if you no longer have the branches around...

But even if you kept all the old refs, this would return
"another-topic"+"master", which is hardly the right answer.

artur
