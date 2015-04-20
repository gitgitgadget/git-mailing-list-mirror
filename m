From: Dmitry Gutov <dgutov@yandex.ru>
Subject: Re: How do I resolve conflict after popping stash without
 adding the file to index?
Date: Tue, 21 Apr 2015 01:54:56 +0300
Message-ID: <553583C0.6090404@yandex.ru>
References: <5535697E.2030204@yandex.ru> <xmqqsibujyit.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 00:55:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkKaq-0006Iw-9x
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 00:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664AbbDTWzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 18:55:03 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:36388 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbbDTWzB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 18:55:01 -0400
Received: by wgsk9 with SMTP id k9so194663659wgs.3
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 15:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=umZ13TM3iuEchAJyilfAS2N3NByEkJE3dULXEZ9WzzY=;
        b=wGIzT6IzDAe6A0jDdoEk6OF9HFTGjvYiekkz8AJ0sesUpvD09YDajpurRm/6KgdBWx
         9fgSk++PNib4p+mWH14OEuK2TVYmPyeCczV9w2UYdONK5KnsPbQqYAFVIXyRy/K63vH6
         2HOFHIJvqylJzFcHxhRDitUWlBmX9J0yEUVvafIe+O1uH613BxIqk35+UWI/C2fYlYo8
         SDV1JIbsPPKraYfvatpQMtv5TKUCkPI9ba35onMt7xCbY+jHB4u6y5C8mhDSKLf6NpOa
         IHJWYGD0os2egYu2ptv6CIucOzi7nqxRiAXEtTSPMx44rWaCLmfikCJDuY2Mc2h1l/4Z
         JtPQ==
X-Received: by 10.194.133.71 with SMTP id pa7mr35970818wjb.155.1429570500730;
        Mon, 20 Apr 2015 15:55:00 -0700 (PDT)
Received: from [192.168.1.2] ([82.102.93.54])
        by mx.google.com with ESMTPSA id dj5sm50932wjb.28.2015.04.20.15.54.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2015 15:54:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:36.0) Gecko/20100101 Thunderbird/36.0
In-Reply-To: <xmqqsibujyit.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267510>

On 04/21/2015 12:11 AM, Junio C Hamano wrote:

> But the said file, if it had conflicted, would have had only the
> conflicted higher stage entries in the index, no?  That is, the
> failed merge wouldn't have touched the index for the path if it
> already had changes there in the first place.

I'm not really sure what "higher stage entries" are, but this scenario 
seems to be a counter-example:

git init
echo "aaaaa" > test
git add test
git commit -m "first"
echo "aaa" > test
git stash save
echo "bbbbb" > test
git add test
git stash pop

Either that, or 'git stash pop' was a destructive operation, and ate the 
staged changes.

> If you want to keep them then you do not have to reset, but your
> question is about resolving conflict only in the working tree and
> leave the index clean, so I do not think "git reset -- $path" would
> not lose anything "irreversibly".

Rather, I'd prefer to leave the index as-is, if it makes sense.

Basically, this is about tool automation, see the context here: 
http://debbugs.gnu.org/cgi/bugreport.cgi?bug=20292
