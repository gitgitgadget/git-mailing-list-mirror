Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAC621F935
	for <e@80x24.org>; Mon, 26 Sep 2016 06:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761190AbcIZGs4 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 26 Sep 2016 02:48:56 -0400
Received: from mail.pdinc.us ([67.90.184.27]:50696 "EHLO mail.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757273AbcIZGsz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 02:48:55 -0400
X-Greylist: delayed 3450 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Sep 2016 02:48:55 EDT
Received: from black7 (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail.pdinc.us (8.14.4/8.14.4) with ESMTP id u8Q5pOtt006119
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 01:51:24 -0400
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Subject: git-upload-pack hangs
Date:   Mon, 26 Sep 2016 01:51:22 -0400
Organization: PD Inc
Message-ID: <C4943B5677A84E80B68F262D43419780@black7>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdIXugLhNNMUd/T+SzyAnGWQrIniwg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.1.7601.17609
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git is hanging on clone. I am runnig (cygwin) git 2.8.3 on IIS7 (windows server 2012 R2).

Where can I start to perform additional debugging?

Selected items I have read, but they did not help:

http://unix.stackexchange.com/questions/98959/git-upload-pack-hangs-indefinitely

https://sparethought.wordpress.com/2012/12/06/setting-git-to-work-behind-ntlm-authenticated-proxy-cntlm-to-the-rescue/

https://sourceforge.net/p/cntlm/bugs/24/

invocation of the clone:

jpyeron.adm@SERVER /tmp
$ GIT_TRACE=1  GIT_CURL_VERBOSE=true git clone http://SERVER.domain.com/git/test.git
01:23:37.020476 git.c:350               trace: built-in: git 'clone' 'http://SERVER.domain.com/git/test.git'
Cloning into 'test'...
01:23:37.206046 run-command.c:336       trace: run_command: 'git-remote-http' 'origin' 'http://SERVER.domain.com/git/test.git'
* STATE: INIT => CONNECT handle 0x60009a140; line 1397 (connection #-5000)
* Couldn't find host SERVER.domain.com in the .netrc file; using defaults
* Added connection 0. The cache now contains 1 members
*   Trying ::1...
* TCP_NODELAY set
* STATE: CONNECT => WAITCONNECT handle 0x60009a140; line 1450 (connection #0)
* Connected to SERVER.domain.com (::1) port 80 (#0)
* STATE: WAITCONNECT => SENDPROTOCONNECT handle 0x60009a140; line 1557 (connection #0)
* Marked for [keep alive]: HTTP default
* STATE: SENDPROTOCONNECT => DO handle 0x60009a140; line 1575 (connection #0)
> GET /git/test.git/info/refs?service=git-upload-pack HTTP/1.1
Host: SERVER.domain.com
User-Agent: git/2.8.3
Accept: */*
Accept-Encoding: gzip
Accept-Language: en-US, *;q=0.9
Pragma: no-cache

* STATE: DO => DO_DONE handle 0x60009a140; line 1654 (connection #0)
* STATE: DO_DONE => WAITPERFORM handle 0x60009a140; line 1781 (connection #0)
* STATE: WAITPERFORM => PERFORM handle 0x60009a140; line 1791 (connection #0)
* HTTP 1.1 or later with persistent connection, pipelining supported
< HTTP/1.1 200 OK
< Cache-Control: no-cache, max-age=0, must-revalidate
< Pragma: no-cache
< Content-Type: application/x-git-upload-pack-advertisement
< Expires: Fri, 01 Jan 1980 00:00:00 GMT
* Server Microsoft-IIS/8.5 is not blacklisted
< Server: Microsoft-IIS/8.5
< X-Powered-By: ASP.NET
< Date: Mon, 26 Sep 2016 05:23:37 GMT
* Marked for [closure]: Connection: close used
< Connection: close
< Content-Length: 310
<
* STATE: PERFORM => DONE handle 0x60009a140; line 1955 (connection #0)
* multi_done
* Curl_http_done: called premature == 0
* Closing connection 0
* The cache now contains 0 members
01:23:37.688252 run-command.c:336       trace: run_command: 'fetch-pack' '--stateless-rpc' '--stdin' '--lock-pack' '--thin' '--check-self-contained-and-connected' '--cloning' 'http://SERVER.domain.com/git/test.git/'
01:23:37.717168 exec_cmd.c:120          trace: exec: 'git' 'fetch-pack' '--stateless-rpc' '--stdin' '--lock-pack' '--thin' '--check-self-contained-and-connected' '--cloning' 'http://SERVER.domain.com/git/test.git/'
01:23:37.749820 git.c:350               trace: built-in: git 'fetch-pack' '--stateless-rpc' '--stdin' '--lock-pack' '--thin' '--check-self-contained-and-connected' '--cloning' 'http://SERVER.domain.com/git/test.git/'
* STATE: INIT => CONNECT handle 0x60009a140; line 1397 (connection #-5000)
* Couldn't find host SERVER.domain.com in the .netrc file; using defaults
* Added connection 1. The cache now contains 1 members
* Hostname SERVER.domain.com was found in DNS cache
*   Trying ::1...
* TCP_NODELAY set
* STATE: CONNECT => WAITCONNECT handle 0x60009a140; line 1450 (connection #1)
* Connected to SERVER.domain.com (::1) port 80 (#1)
* STATE: WAITCONNECT => SENDPROTOCONNECT handle 0x60009a140; line 1557 (connection #1)
* Marked for [keep alive]: HTTP default
* STATE: SENDPROTOCONNECT => DO handle 0x60009a140; line 1575 (connection #1)
> POST /git/test.git/git-upload-pack HTTP/1.1
Host: SERVER.domain.com
User-Agent: git/2.8.3
Accept-Encoding: gzip
Content-Type: application/x-git-upload-pack-request
Accept: application/x-git-upload-pack-result
Content-Length: 140

* upload completely sent off: 140 out of 140 bytes
* STATE: DO => DO_DONE handle 0x60009a140; line 1654 (connection #1)
* STATE: DO_DONE => WAITPERFORM handle 0x60009a140; line 1781 (connection #1)
* STATE: WAITPERFORM => PERFORM handle 0x60009a140; line 1791 (connection #1)


--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- 


