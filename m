From: Stefan Saasen <ssaasen@atlassian.com>
Subject: Re: [BUG] Performance regression due to #33d4221: write_sha1_file:
 freshen existing objects
Date: Sat, 18 Apr 2015 13:35:51 +1000
Message-ID: <CADoxLGOPXDgb0LBcSBm+xRDhbnGV_y-TXENyPV7oK_+KZzPKRQ@mail.gmail.com>
References: <CADoxLGPYOkgzb4bkdHq5tK0aJS2M=nWGzO=YYXPDcy-gh45q-g@mail.gmail.com>
 <20150417140315.GA13506@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 18 05:36:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjJYg-0005pa-5K
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 05:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282AbbDRDge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 23:36:34 -0400
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:54590 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751705AbbDRDgd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Apr 2015 23:36:33 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]) (using TLSv1) by na3sys009aob127.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVTHRQKVnRXGfmy58kR+hKHVklwd0yd6J@postini.com; Fri, 17 Apr 2015 20:36:32 PDT
Received: by iget9 with SMTP id t9so36181347ige.1
        for <git@vger.kernel.org>; Fri, 17 Apr 2015 20:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=aeUyfND1zkjxkEfdpo+rZFZ5ZIBa0YIkDYHFgAis03Y=;
        b=P+Yd/i+1GsPP01d5NNnJhxoCiCroY1gSh+cOlLnKtxMAYF37mIMzdATYlv/aDptvtJ
         aZ/k3LhuxL1dCbE/70F6UCSzEBplVA8ipqLSK+FYEnH7ZWqWMm2t+yPypMbY/H1LfWGE
         obY/0zywOL0oYHeo+iObSdzbbPA/aGMRXPZ4/9q9O5gc4hIyJwXad+bKXEKzwgImr/0f
         R6efszBiyuMT6x7Rn1HKIhh16y25PSt3xXhVWi8UOShLAFn3Rj0AlmnDgNSQZpAwH46+
         Z1B/2zCpnV3I9dXRhzQ8BCPDHnfDcGQ76FKy52O2R1Gbfe5htTjtufSUBmnLDRKBj+U7
         +rWQ==
X-Gm-Message-State: ALoCoQk6AW/2wOlLE1JqwJwwEM0vYoLaZNdF4X680HQaxV9VPczjdLZfHi6vTqD4y4LVrE/xDKkvWQUdCw/qM/45k8jTqThcjkulx2uTveTop9SQ3yfB6ESrKfeMKY+I1AsZ5ZMyaGMZyQuMAn/234vWQUqKaJi3MQ==
X-Received: by 10.50.29.40 with SMTP id g8mr6952929igh.41.1429328192178;
        Fri, 17 Apr 2015 20:36:32 -0700 (PDT)
X-Received: by 10.50.29.40 with SMTP id g8mr6952920igh.41.1429328192058; Fri,
 17 Apr 2015 20:36:32 -0700 (PDT)
Received: by 10.36.118.133 with HTTP; Fri, 17 Apr 2015 20:35:51 -0700 (PDT)
In-Reply-To: <20150417140315.GA13506@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267405>

> If it's not a problem, I'd love to see timings for your case with just
> the first patch, and then with both.

Thanks for the swift response, much appreciated Jeff!

Here are the timings for the two patches:

Patch 1 on top of 33d4221c79

       Elapsed           System              User
 Min.   :6.110   Min.   :0.6700   Min.   :0.3600
 1st Qu.:6.580   1st Qu.:0.6900   1st Qu.:0.3900
 Median :7.260   Median :0.7100   Median :0.4100
 Mean   :7.347   Mean   :0.7248   Mean   :0.4214
 3rd Qu.:8.000   3rd Qu.:0.7400   3rd Qu.:0.4600
 Max.   :8.860   Max.   :0.8700   Max.   :0.5100

I've had to slightly tweak your second patch (`freshened` was never
set) but applying the modified patch yielded even better results
compared to patch 1:

       Elapsed           System              User
 Min.   :0.38   Min.   :0.03000   Min.   :0.2900
 1st Qu.:0.38   1st Qu.:0.04000   1st Qu.:0.3100
 Median :0.39   Median :0.06000   Median :0.3200
 Mean   :0.43   Mean   :0.05667   Mean   :0.3519
 3rd Qu.:0.42   3rd Qu.:0.07000   3rd Qu.:0.3600
 Max.   :0.68   Max.   :0.08000   Max.   :0.5700

This is pretty much back to the "before" state.
The graph really tells the whole story:
https://bytebucket.org/snippets/ssaasen/GeRE/raw/7367353a58c50ccd7c493af40ffb6ba1533e1490/git-merge-timing-patched.png
(After is the change in #33d4221, Before the parent of #33d4221 and so on)
The graph and the NFS stats can be found here:
https://bitbucket.org/snippets/ssaasen/GeRE

My tweaked version of your second patch is:

diff --git a/cache.h b/cache.h
index 51ee856..8982055 100644
--- a/cache.h
+++ b/cache.h
@@ -1168,6 +1168,7 @@ extern struct packed_git {
        int pack_fd;
        unsigned pack_local:1,
                 pack_keep:1,
+               freshened:1,
                 do_not_close:1;
        unsigned char sha1[20];
        /* something like ".git/objects/pack/xxxxx.pack" */
diff --git a/sha1_file.c b/sha1_file.c
index bc6322e..c0ccd4b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2999,7 +2999,11 @@ static int freshen_loose_object(const unsigned
char *sha1)
 static int freshen_packed_object(const unsigned char *sha1)
 {
        struct pack_entry e;
-       return find_pack_entry(sha1, &e) && freshen_file(e.p->pack_name);
+       if (!find_pack_entry(sha1, &e))
+              return 0;
+       if (e.p->freshened)
+              return 1;
+       return e.p->freshened = freshen_file(e.p->pack_name);
 }

 int write_sha1_file(const void *buf, unsigned long len, const char
*type, unsigned char *returnsha1)



The only change is that I assign the result of `freshen_file` to the
`freshened` flag.

I've only ran this with the test case I was using before but it looks
like this is pretty much fixing the merge time changes we observed.

Thanks again for the swift response. I've got my test setup sitting
here, happy to rerun the tests if that'd be useful.

Is there a chance to backport those changes to the 2.2+ branches?

> You may also be interested in:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/266370
>
> which addresses another performance problem related to the
> freshen/recent code in v2.2.

Thanks for the pointer, I'll have a look at that as well.

Cheers,
Stefan
