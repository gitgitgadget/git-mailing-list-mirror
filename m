From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git status: small difference between stating whole repository and
 small subdirectory
Date: Mon, 13 Feb 2012 17:54:04 +0100
Message-ID: <CAA01CsqjeDR56n=gdLWtDshp8-=8_cSih9vHV3vnUx0wTockYg@mail.gmail.com>
References: <CAA01Csr8FbvQ8uFvxX8_6i-hysin6JuaifVVC-yoLyoT0N5F4Q@mail.gmail.com>
	<CACsJy8DnqYZ5CdZqbebWS4NS85mfwumyao0abeqDxMXrHhDELA@mail.gmail.com>
	<CAA01Csq+zVhRTjGqy1DJGK7o5wByd9ADsSim214T7Vkxmk+ykQ@mail.gmail.com>
	<CACsJy8C05wvQRRQJLxrxYKHjXsgh6RugFexkPUKYGxbQkqiXJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 17:54:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwzAK-0004Gk-BN
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 17:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757272Ab2BMQyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 11:54:06 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55972 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757227Ab2BMQyF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 11:54:05 -0500
Received: by iacb35 with SMTP id b35so4644471iac.19
        for <git@vger.kernel.org>; Mon, 13 Feb 2012 08:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qwr7OgOQr8F9Fh/y9xoDjClS/DBUtjwSDIUZtE4erBU=;
        b=VnvJfPhKVJDPp5Zz1ai4QSCMLlOv6UaQalbHX4rf90Y24ML5ymcTYRVxWjO73hRHf6
         k5DtZ0JwUYlP/eYrr+OBrI+hlrHzJxHJWu0s8UaOFLU/gJmmKetzwLoklO1Yky6KCh1D
         w5cxqY/MsPcMro9H77yqGJEigqAKE4OYxlQZo=
Received: by 10.42.145.131 with SMTP id f3mr26919329icv.8.1329152044900; Mon,
 13 Feb 2012 08:54:04 -0800 (PST)
Received: by 10.50.46.33 with HTTP; Mon, 13 Feb 2012 08:54:04 -0800 (PST)
In-Reply-To: <CACsJy8C05wvQRRQJLxrxYKHjXsgh6RugFexkPUKYGxbQkqiXJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190638>

On Fri, Feb 10, 2012 at 3:37 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> I think the cost is in $GIT_DIR, not the working directory.

Could you explain?


I got the problem again today. This time I've made a copy of the
repository so hopefully I'll able to reproduce the problems.

This time it's a different repository but the 'status' on a small
subdirectory is even more than 2x slower than on the whole repository.

Whole repo:
$ find * -type f | wc -l
33021
$ du -shc * | grep total
2.1G	total

The subdir:
$ find * -type f | wc -l
17
$ du -shc * | grep total
84K	total

As previously, timing was done with cold cache (echo 3 | sudo tee
/proc/sys/vm/drop_caches) and executed several times.

This time I have used recent git (1.7.9.188.g12766) compiled with -pg.
git was executed in the subdirectory. Tracked files were not
changed/deleted, there was just a couple of small untracked files.

Timings:

$ time git status
real	0m16.595s
user	0m0.680s
sys	0m0.616s

$ time git status -- .
real	0m10.030s
user	0m0.464s
sys	0m0.184s

You can find gprof output here:
http://pastebin.com/mhddDUmv - from whole repo status
http://pastebin.com/1LdVn77A - from subdir status



-- 
Piotr Krukowiecki
