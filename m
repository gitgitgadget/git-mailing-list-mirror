From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: pack operation is thrashing my server
Date: Sat, 6 Sep 2008 23:43:35 -0400
Message-ID: <9e4733910809062043y661d2d54rcb034d4c70296727@mail.gmail.com>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
	 <alpine.LFD.1.10.0808141442150.4352@xanadu.home>
	 <alpine.LFD.1.10.0808141215520.3324@nehalem.linux-foundation.org>
	 <alpine.LFD.1.10.0808141633080.4352@xanadu.home>
	 <alpine.LFD.1.10.0808141544150.3324@nehalem.linux-foundation.org>
	 <alpine.LFD.1.10.0808151729070.3324@nehalem.linux-foundation.org>
	 <7vk5dorclv.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.1.10.0809061812090.3117@nehalem.linux-foundation.org>
	 <9e4733910809061950g6d9d2cf1g708f8faf0c06108@mail.gmail.com>
	 <alpine.LFD.1.10.0809061957320.3117@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Sep 07 05:47:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcBEB-0005hJ-FW
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 05:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644AbYIGDnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 23:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753648AbYIGDnh
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 23:43:37 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:14177 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbYIGDnh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 23:43:37 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1061448wri.5
        for <git@vger.kernel.org>; Sat, 06 Sep 2008 20:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2dOkqeE6LvQL61S9yIXtgk2Fyo6L2c0jYq3u9BlLcUw=;
        b=qiNUirRdpzf0JZU98qU5QAyyrDrF+q70yc84Krt5O+sKYT0wMGBCEw8NnJIdRJ9jIZ
         /lS4rUudzF/gFXVKQ2nSX/E9FU7Tz3B+EMO/PMx9IwcgzcT9ZWbsJEql6Eau7Ofczbnp
         Fy2T8EAcT1fFDc0ZmqB1jC3T3ylkD/SKSyTK4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=CuGIn0ucgeb7vTu+j6QGO2sOSqeyHge8oPLpdq9hVN9lkF1suSW9aFBu8rgTovcmkz
         g3EARIzQlIXyjbM6CV2KbWQPAvwq0ts1OlOrlOcRIY1toQZkBDStcsowUq74OwI13Y1w
         LpDs6zuG6Dd7x7DydhjCUCLNfZCXeB0xZ8GsQ=
Received: by 10.70.10.3 with SMTP id 3mr16870496wxj.62.1220759015384;
        Sat, 06 Sep 2008 20:43:35 -0700 (PDT)
Received: by 10.70.55.6 with HTTP; Sat, 6 Sep 2008 20:43:35 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0809061957320.3117@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95108>

On 9/6/08, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
>  On Sat, 6 Sep 2008, Jon Smirl wrote:
>  >
>  > Some alternative algorithms are here...
>  > http://cs.fit.edu/~mmahoney/compression
>  > It is possible to beat zlib by 2x at the cost of CPU time and memory.
>
>
> Jon, you're missing the point.
>
>  The problem with zlib isn't that it doesn't compress well. It's that it's
>  too _SLOW_.

When I was playing with those giant Mozilla packs speed of zlib wasn't
a big problem. Number one problem was the repack process exceeding 3GB
which forced me to get 64b hardware and 8GB of memory. If you start
swapping in a repack, kill it, it will probably take a month to
finish.

I'm forgetting the numbers now but on a quad core machine (with git
changes to use all cores) and 8GB I believe I was able to repack the
Mozilla repo in under an hour. At that point I believe I was being
limited by disk IO.

Size and speed are not unrelated. Buy reducing the pack size in half
you reduce the IO and memory demands (cache misses) a lot. For example
if we went to no compression we'd be killed by memory and IO
consumption. It's not obvious to me what's the best trade off for git
without trying several compression algorithms and comparing. They were
feeding 100MB into PAQ on that site, I don't know what PAQ would do
with a bunch of 2K objects.

Most delta chains in the Mozilla data were easy to process. There was
a single 2000 delta chain that consumed 15% of the total CPU time to
process. Something causes performance to fall apart on really long
chains.

>  > Turning a 500MB packfile into a 250MB has lots of advantages in IO
>  > reduction so it is worth some CPU/memory to create it.
>
>
> ..and secondly, there's no way you'll find a compressor that comes even
>  close to being twice as good. 10% better yes - but then generally much
>  MUCH slower.
>
>  Take a look at that web page you quote, and then sort things by
>  decompression speed. THAT is the issue.
>
>  And no, LZO isn't even on that list. I haven't tested it, but looking at
>  the code, I do think LZO can be fast exactly because it seems to be
>  byte-based rather than bit-based, so I'd not be surprised if the claims
>  for its uncompression speed are true.
>
>  The constant bit-shifting/masking/extraction kills zlib performance (and
>  please realize that zlib is at the TOP of the list when looking at the
>  thing you pointed to - that silly site seems to not care about compressor
>  speed at all, _only_ about size). So "kills" is a relative measure, but
>  really - we're looking for _faster_ algorithms, not slower ones!
>
>
>                         Linus
>


-- 
Jon Smirl
jonsmirl@gmail.com
