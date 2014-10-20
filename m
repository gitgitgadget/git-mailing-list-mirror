From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: git fetch (http) hanging/failing on one specific repository, http
 only
Date: Mon, 20 Oct 2014 16:29:15 +0200
Message-ID: <1413815355.4175.26.camel@seahawk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 20 16:29:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgDxf-0000pc-PL
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 16:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbaJTO3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 10:29:24 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:34953 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbaJTO3T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 10:29:19 -0400
Received: by mail-la0-f45.google.com with SMTP id q1so4077174lam.18
        for <git@vger.kernel.org>; Mon, 20 Oct 2014 07:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:content-type
         :mime-version:content-transfer-encoding;
        bh=Vt/XrBmobv6jmdXR/42tS3pmh7PIuTP6peqAazJmPlA=;
        b=c8vWEkEnv0xfP2upna26SjStCZ6eWZN9PEcjeNr7FMR3esjoaauz8qPBbhoM4WL3Fk
         XdShQppgA+vFr7vlY0zQCzCGAjnurTNuMD7MRn/gGATg7lqyeLRGVbHjJfi64tuTfrtl
         NZlr87ElvOzy6NOhLEaRahiRRgpfcdyd8IQR7zgcPS55gapSfLXDvfSIqG0O92yLBkPt
         QW8mCWH5wR09DaMsUTQMaj9F34SwTW9DQ9YnmYg9O+Bf9Cp3RjTKt7xEo17AOf8BsJva
         Og9RldoRMqMfjF+Gj2QJXUhswID56pCGJG2PrjRtUH+Dyv7ShJR4sbsj4IH3Ntie1eNI
         kDfg==
X-Gm-Message-State: ALoCoQkN6tNN3K/6s0a9KodbeDMa6I2cYOYX3ughmsNv91APftT4nFC0MuHjyInsb3OfxtCvyfeo
X-Received: by 10.152.8.12 with SMTP id n12mr27712510laa.51.1413815357823;
        Mon, 20 Oct 2014 07:29:17 -0700 (PDT)
Received: from [10.155.73.62] (proxy-gw-l.booking.com. [5.57.20.8])
        by mx.google.com with ESMTPSA id x6sm3351011lbj.40.2014.10.20.07.29.16
        for <git@vger.kernel.org>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 07:29:17 -0700 (PDT)
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since a few days, one of our repos is causing problems during git fetch,
basically git fetch over http hangs during find_common. When using ssh,
this does not happen. One thing to noe about this repo is that it has
53000+ refs, though I'm not convinced that that is the cause of my
ptoblem.

Client and server are both 2.1.2, the 'dirty' is from some debugging
printf's I threw in. I also tested with 1.8.4, which also exhibits this
behaviour:

GIT_CURL_VERBOSE=1 /home/dkaarsemaker/git/git fetch -vvv

* Couldn't find host xxx.booking.com in the .netrc file; using defaults
* Expire cleared
* About to connect() to xxx.booking.com port 80 (#0)
*   Trying 10.196.70.243... >
GET /git/main.git/info/refs?service=git-upload-pack HTTP/1.1
User-Agent: git/2.1.2.dirty
Host: xxx.booking.com
Accept: */*
Accept-Encoding: gzip
Pragma: no-cache

< HTTP/1.1 200 OK
< Date: Mon, 20 Oct 2014 13:41:00 GMT
< Server: Apache
< Expires: Fri, 01 Jan 1980 00:00:00 GMT
< Pragma: no-cache
< Cache-Control: no-cache, max-age=0, must-revalidate
< Transfer-Encoding: chunked
< Content-Type: application/x-git-upload-pack-advertisement
< 
* Expire cleared
* Connection #0 to host xxx.booking.com left intact
HEADServer supports multi_ack_detailed
Server supports no-done
Server supports side-band-64k
Server supports ofs-delta
Server version is git/2.1.2
want dfb112668697c44d3221ce1e603af1ee46fff41e (refs/heads/xxx)
want e884b8d79a935fdc9291c2424372cd372f0b7666 (refs/heads/xxx)
want d83ee364a2be10ea5d9fa9c19a64d8680f7f2327 (refs/heads/xxx)
want 3cf9d21630bb5e380be3537628cd026ddfee8a11 (refs/heads/xxx)
want 0ecb911a9062d2a94c5381efab8b10d76acfa487 (refs/heads/xxx)
want 53dca992d6162fb08a1c722317621866ade339ca (refs/heads/xxx)
want 49de5539e17ed53706159f4fdda2bdacac18f9d6 (refs/heads/xxx)
want 6fb579642139bff5e28f313012dbe7ffe4f3aae5 (refs/heads/xxx)
want 62bf71564cc70c3d9a5cd8046b09e136f9e27928 (refs/heads/xxx)
want c1f98f24174113f901950506ab6a08c54c88e867 (refs/heads/xxx)
want 830ee444f8e9f3127ee7c8ac054690581e6bea53 (refs/heads/xxx)
want dd7a12a3f7344e78136fe8ea1d8bd5b8a7592bda (refs/heads/xxx)
want acc5936de82f6f31a50a3c68dc1fe22bfe5818ef (refs/heads/xxx)
want 88c5f7c05e55a83826112c4cc19e2e9fc53bbdfb (refs/heads/xxx)
want 639339def49ba7f3d469413e7d26e0d205fa23b7 (refs/heads/xxx)
want 65a12becb29987726864709429052f8b63a9e468 (refs/heads/xxx)
want 69375797ac43b2427d6c88a07202cb986eb0e91e (refs/heads/xxx)
want c32e7a453643f43ad3a840d8972a591345eb4ce6 (refs/heads/xxx)
want 024a9c8904934522a8a625145997b118cb07ea85 (refs/heads/xxx)
want 7f3b10df5ddb7eb4d8b310812e7406515ff9c439 (refs/heads/xxx)
want 762cf79100279f14c1d6089daacd7a800d4574d9 (refs/heads/xxx)
want 8b74fe415472720cc72c761af8025e730f8378ce (refs/heads/xxx)
want 811b5bea55533bcc158da1a568b92a070a5aff46 (refs/heads/xxx)
want 8a46fb3dedb55e63fa580541c9f7633d425a8ea2 (refs/heads/xxx)
want d81598d11edcbda0e020b63c3ae6084029b0714c (refs/heads/xxx)
want 0641ea1ab05775a73f7e99342859ee638b534159 (refs/heads/xxx)
want 837466f5fbd51cf21c93e5d44124dce42deac469 (refs/heads/trunk)
want 8225bf4201c14518eef7c81c8964b5f11b12c0eb (refs/heads/xxx)
want d366df049d50d879cc3dfaced812ebac91a987ba (refs/heads/xxx)
want c47ff2f1b8155dd8a9e0113fd92c3a109dce72b7 (refs/heads/xxx)
want dd136cdae6ef772323b922c15b6166666ad987de (refs/tags/admin-20141016-163909)
<skip 150-odd tags with the same format

<skip lots of back anf forth have/ack, here are the apache logs for them>
10.189.174.96 - - [20/Oct/2014:15:41:04 +0200] "POST /git/main.git/git-upload-pack HTTP/1.1" 200 904
10.189.174.96 - - [20/Oct/2014:15:41:04 +0200] "POST /git/main.git/git-upload-pack HTTP/1.1" 200 1576
10.189.174.96 - - [20/Oct/2014:15:41:04 +0200] "POST /git/main.git/git-upload-pack HTTP/1.1" 200 3312
10.189.174.96 - - [20/Oct/2014:15:41:04 +0200] "POST /git/main.git/git-upload-pack HTTP/1.1" 200 6784
10.189.174.96 - - [20/Oct/2014:15:41:04 +0200] "POST /git/main.git/git-upload-pack HTTP/1.1" 200 13728
10.189.174.96 - - [20/Oct/2014:15:41:05 +0200] "POST /git/main.git/git-upload-pack HTTP/1.1" 200 27840
10.189.174.96 - - [20/Oct/2014:15:41:05 +0200] "POST /git/main.git/git-upload-pack HTTP/1.1" 200 55392
10.189.174.96 - - [20/Oct/2014:15:41:05 +0200] "POST /git/main.git/git-upload-pack HTTP/1.1" 200 112456
10.189.174.96 - - [20/Oct/2014:15:41:06 +0200] "POST /git/main.git/git-upload-pack HTTP/1.1" 200 169800
10.189.174.96 - - [20/Oct/2014:15:41:06 +0200] "POST /git/main.git/git-upload-pack HTTP/1.1" 200 227144

<skip lots of acks>
got ack 3 87f1981596402d37d905dfb5356be7aa99020053
got ack 3 5ed75db2add2ae8abfb888fac1502ed3fac0221e
got ack 3 ee08fd65a137548c6769bf703f4da07307c3023d
<skip lots of haves>
have d6d890f55dcf83d1f6a6328c07a57b0c60f28e30
have bd94ba6d06011aaaf620abcea37e756a590bebd5
have 3946073390c2548a3f065c88f41a4b8964b9a2dd
have 34f881dbb4af0e3b090a93b17fba9c31b7771f61
have a7c18a679ce9e6eefe7930556735b29ecfc33952
POST git-upload-pack (gzip 262103 to 130185 bytes)
* Couldn't find host xxx.booking.com in the .netrc file; using defaults
* Re-using existing connection! (#0) with host xxx.booking.com
* Connected to xxx.booking.com (10.196.70.243) port 80 (#0)
> POST /git/main.git/git-upload-pack HTTP/1.1
User-Agent: git/2.1.2.dirty
Host: xxx.booking.com
Accept-Encoding: gzip
Content-Type: application/x-git-upload-pack-request
Accept: application/x-git-upload-pack-result
Content-Encoding: gzip
Content-Length: 130185

And here it hangs. The request does not show up in the apache
access/error log. The upload-pack process does get started though, but
git-upload-pack and git-http-backend seem deadlocked. strace shows:

sudo strace -p 3094 -p 3095 -p 3096
Process 3094 attached - interrupt to quit
Process 3095 attached - interrupt to quit
Process 3096 attached - interrupt to quit
[pid  3095] wait4(3096,  <unfinished ...>
[pid  3096] write(1, "0038ACK f3e8514d6e1dd402d27fecd9"..., 56 <unfinished ...>
[pid  3094] write(4, "32have e099999f7a64a93bcf8dd7f59"..., 8192 <unfinished ...>


3094, 3095, 3096 are git-http-backend, git upload pack and
git-upload-pack respectively.

Backtrace for the hanging git-fetch-pack (not suer if relevant):
#0  0x00007feb7abbf530 in __read_nocancel () from /lib64/libpthread.so.0
#1  0x000000000051531c in xread (fd=0, buf=0x7fff9fc04a60, len=4) at wrapper.c:152
#2  0x000000000051539b in read_in_full (fd=0, buf=<value optimized out>, count=4) at wrapper.c:201
#3  0x00000000004cea39 in get_packet_data (fd=<value optimized out>, src_buf=0x0, src_size=0x0, 
    dst=<value optimized out>, size=4, options=2) at pkt-line.c:122
#4  0x00000000004ceced in packet_read (fd=<value optimized out>, src_buf=0x0, src_len=0x0, 
    buffer=0x7d7560 "ACK c6597d5122bf0a5c831b4585cd2ad92d953cbdc9 common", size=65520, options=2) at pkt-line.c:169
#5  0x00000000004cee7e in packet_read_line_generic (fd=<value optimized out>, len_p=<value optimized out>)
    at pkt-line.c:199
#6  packet_read_line (fd=<value optimized out>, len_p=<value optimized out>) at pkt-line.c:209
#7  0x00000000004a6504 in get_ack (fd=0, 
    result_sha1=0x7fff9fc04ba0 "\306Y}Q\"\277\n\\\203\033E\205\315*\331-\225<\275", <incomplete sequence \311>)
    at fetch-pack.c:194
#8  0x00000000004a8062 in find_common (args=<value optimized out>, fd=0x7fff9fc04ce0, conn=<value optimized out>, 
    ref=<value optimized out>, dest=<value optimized out>, sought=0xe17610, nr_sought=160, shallow=0x7fff9fc04ca0, 
    pack_lockfile=0x7fff9fc04cd8) at fetch-pack.c:391
#9  do_fetch_pack (args=<value optimized out>, fd=0x7fff9fc04ce0, conn=<value optimized out>, 
    ref=<value optimized out>, dest=<value optimized out>, sought=0xe17610, nr_sought=160, shallow=0x7fff9fc04ca0, 
    pack_lockfile=0x7fff9fc04cd8) at fetch-pack.c:856
#10 fetch_pack (args=<value optimized out>, fd=0x7fff9fc04ce0, conn=<value optimized out>, ref=<value optimized out>, 
    dest=<value optimized out>, sought=0xe17610, nr_sought=160, shallow=0x7fff9fc04ca0, pack_lockfile=0x7fff9fc04cd8)
    at fetch-pack.c:1058
#11 0x000000000042baf3 in cmd_fetch_pack (argc=<value optimized out>, argv=<value optimized out>, 
    prefix=<value optimized out>) at builtin/fetch-pack.c:180
#12 0x0000000000404dc5 in run_builtin (argc=9, argv=0x7fff9fc04f90) at git.c:351
#13 handle_builtin (argc=9, argv=0x7fff9fc04f90) at git.c:529
#14 0x0000000000405001 in run_argv (argc=9, av=<value optimized out>) at git.c:575
#15 main (argc=9, av=<value optimized out>) at git.c:662

And for the hanging git-upload-pack:
#0  0x00007f7c8034b4d0 in __write_nocancel () from /lib64/libpthread.so.0
#1  0x000000000043c9dc in xwrite (fd=1, buf=0x6c70e0, len=56) at wrapper.c:170
#2  0x000000000043ca5b in write_in_full (fd=1, buf=<value optimized out>, count=56) at wrapper.c:220
#3  0x000000000043d019 in write_or_die (fd=<value optimized out>, buf=<value optimized out>, 
    count=<value optimized out>) at write_or_die.c:61
#4  0x00000000004131fa in packet_write (fd=1, fmt=<value optimized out>) at pkt-line.c:93
#5  0x000000000040538c in get_common_commits (argc=<value optimized out>, argv=0x7fff00000001) at upload-pack.c:420
#6  upload_pack (argc=<value optimized out>, argv=0x7fff00000001) at upload-pack.c:778
#7  main (argc=<value optimized out>, argv=0x7fff00000001) at upload-pack.c:846

And the hanging git-http-backend:
#0  0x00007f4c9553d4d0 in __write_nocancel () from /lib64/libpthread.so.0
#1  0x000000000042d31c in xwrite (fd=4, buf=0x7fff394ea570, len=8192) at wrapper.c:170
#2  0x000000000042d39b in write_in_full (fd=4, buf=<value optimized out>, count=8192) at wrapper.c:220
#3  0x0000000000403e5d in inflate_request (prog_name=0x490d98 "upload-pack", out=4) at http-backend.c:305
#4  0x000000000040405d in run_service (argv=0x7fff394ee6d0) at http-backend.c:355
#5  0x00000000004041d2 in service_rpc (service_name=<value optimized out>) at http-backend.c:508
#6  0x0000000000404b35 in main (argc=<value optimized out>, argv=<value optimized out>) at http-backend.c:631

Both git-http-backend and git-upload-pack are trying to write at the
same time. I'm *guessing* I've hit some buffer limit here, given that
the have/ack exchanges are increasing in size and suddenly this one is
misbehaving. However I have no idea where to look next and would really
appreciate some help.

-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
