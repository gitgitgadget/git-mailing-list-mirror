From: Vitaly <vitaly.berov@gmail.com>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Mon, 12 Apr 2010 19:31:47 +0400
Message-ID: <4BC33CE3.4030103@gmail.com>
References: <loom.20100406T161552-321@post.gmane.org> <alpine.LFD.2.00.1004061709360.7232@xanadu.home> <4BBC1ED3.6020008@gmail.com> <alpine.LFD.2.00.1004070842580.7232@xanadu.home> <hppu9a$ugq$1@dough.gmane.org> <alpine.LFD.2.00.1004101617460.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 12 17:32:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1Lcp-0001Fv-LR
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 17:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018Ab0DLPca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 11:32:30 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:53999 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840Ab0DLPc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 11:32:29 -0400
Received: by bwz19 with SMTP id 19so51210bwz.21
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 08:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=1KuaD6Q4/WkYVkLXeJuz9JunmjhANoXegsXBRxNcnB8=;
        b=ksJ8hwx7ikTvU1mIvgovyRFpibZwk5scZ56yWY9CAkiwomlGYiD0NjN0sxPknr6l1c
         V34mYHkYF1htZE3zhWTHpWN7vU+g1dvWqKaV8p0IsUJ9ZrlpQ9ILT6hIB/NCc7T9Uhdd
         yjIKRAuOvrImvQtRb3yDtlAVSyJUji0KwO4hM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=NsO9CxukEfQRz4AN0g5m2kY9VFrEo5rXWvUS81rKH06cGKx2YWtbHaMvLi1h6NJHuf
         c7LHjx16UhzOwo70DhgA1AtcpNt0YfHD/fPn/bU+8sVhWAD2iqEVO+EhHo6hpX1CKm1X
         5QU393wAES0cDC2C5RUXmkXeQfok2XmNgwx7s=
Received: by 10.204.3.137 with SMTP id 9mr5103729bkn.6.1271086347201;
        Mon, 12 Apr 2010 08:32:27 -0700 (PDT)
Received: from [172.16.11.219] ([195.218.191.171])
        by mx.google.com with ESMTPS id 15sm1846020bwz.12.2010.04.12.08.32.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 08:32:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9pre) Gecko/20100217 Shredder/3.0.3pre
In-Reply-To: <alpine.LFD.2.00.1004101617460.7232@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144742>

Hello,

On 04/11/2010 04:50 AM, Nicolas Pitre wrote:
> core.deltaBaseCacheLimit. Given that your files are "relatively" small
> i.e. in the 4MB range max, then the cache should be able to hold quite
> many of them.  At the moment with its 16MB limit, only a few of those
> objects would evict many objects from the cache quickly.
>
> If this is still not good enough, then you could add a negative delta
> attribute to those large binary files (see
> http://www.kernel.org/pub/software/scm/git/docs/gitattributes.html)
> and repack the repository on the server.  Of course that will make the
> repository larger and the data transfer longer when cloning, but the
> "resolving deltas" will be much faster.  This is therefore a tradeoff.
>
> Another solution which might be way more practical for users of such a
> huge repository is simply to use a shallow clone.  Surely those people
> cloning this repository might not need the full history of the
> repository.  So you could simply use:
>
> 	git clone --depth=10 ...
>
> and have only the last 10 revisions transferred.  Later on the
> repository can be deepened by passing the --depth argument with a larger
> value to the fetch command if need be.
>
>
> Nicolas
>
>    
Thanks for comprehensive answer, Nicolas. Now I see 3 directions to work 
on: cacheLimit, negative delta attributes and shortening the history 
(actually, I don't think "clone --depth" is feasible in our environment, 
but we can try to backup and just purge the history).
