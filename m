Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B44501F424
	for <e@80x24.org>; Tue,  3 Apr 2018 11:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755405AbeDCLoE (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 07:44:04 -0400
Received: from mailhost.frm2.tum.de ([129.187.179.12]:65323 "EHLO
        mailhost.frm2.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755135AbeDCLoE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 07:44:04 -0400
Received: from mailhost.frm2.tum.de (localhost [127.0.0.1])
        by mailhost.frm2.tum.de (8.15.2/8.15.2) with ESMTP id w33Bi2oL061600
        for <git@vger.kernel.org>; Tue, 3 Apr 2018 13:44:02 +0200 (CEST)
        (envelope-from jens.krueger@frm2.tum.de)
X-Virus-Scanned: at mailhost.frm2.tum.de
Received: from taco6.ictrl.frm2 (taco6.ictrl.frm2 [172.25.2.6])
        (authenticated bits=0)
        by mailhost.frm2.tum.de (8.15.2/8.15.2) with ESMTPSA id w33BhcWj061541
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <git@vger.kernel.org>; Tue, 3 Apr 2018 13:43:38 +0200 (CEST)
        (envelope-from jens.krueger@frm2.tum.de)
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Jens_Kr=c3=bcger?= <Jens.Krueger@frm2.tum.de>
Subject: Test 5561 failed
Message-ID: <66ac8aec-3e4c-43be-83d1-7bd823ec2b20@frm2.tum.de>
Date:   Tue, 3 Apr 2018 13:43:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------6EDB7F9887AB99E95017C1FE"
Content-Language: en-US
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mailhost.frm2.tum.de [129.187.179.12]); Tue, 03 Apr 2018 13:43:38 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------6EDB7F9887AB99E95017C1FE
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Git version 2.17.0

OS: Debian 9 (9.4)

gcc: gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516

build from github clone:

autoreconf
./configure
make
make test

*** t5561-http-backend.sh ***
ok 1 - setup repository
not ok 2 - direct refs/heads/master not found
#
#               GET refs/heads/master "404 Not Found"
#
not ok 3 - static file is ok
#
#               get_static_files "200 OK"
#
not ok 4 - no export by default
#
#               get_static_files "404 Not Found"
#
not ok 5 - export if git-daemon-export-ok
#
#               (cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
#                touch git-daemon-export-ok
#               ) &&
#               get_static_files "200 OK"
#
not ok 6 - static file if http.getanyfile true is ok
#
#               config http.getanyfile true &&
#               get_static_files "200 OK"
#
not ok 7 - static file if http.getanyfile false fails
#
#               config http.getanyfile false &&
#               get_static_files "403 Forbidden"
#
not ok 8 - http.uploadpack default enabled
#
#               GET info/refs?service=git-upload-pack "200 OK" &&
#               POST git-upload-pack 0000 "200 OK"
#
not ok 9 - http.uploadpack true
#
#               config http.uploadpack true &&
#               GET info/refs?service=git-upload-pack "200 OK" &&
#               POST git-upload-pack 0000 "200 OK"
#
not ok 10 - http.uploadpack false
#
#               config http.uploadpack false &&
#               GET info/refs?service=git-upload-pack "403 Forbidden" &&
#               POST git-upload-pack 0000 "403 Forbidden"
#
not ok 11 - http.receivepack default disabled
#
#               GET info/refs?service=git-receive-pack "403 Forbidden"  &&
#               POST git-receive-pack 0000 "403 Forbidden"
#
not ok 12 - http.receivepack true
#
#               config http.receivepack true &&
#               GET info/refs?service=git-receive-pack "200 OK" &&
#               POST git-receive-pack 0000 "200 OK"
#
not ok 13 - http.receivepack false
#
#               config http.receivepack false &&
#               GET info/refs?service=git-receive-pack "403 Forbidden" &&
#               POST git-receive-pack 0000 "403 Forbidden"
#
not ok 14 - server request log matches test results
#
#               sed -e "
#                       s/^.* \"//
#                       s/\"//
#                       s/ [1-9][0-9]*\$//
#                       s/^GET /GET  /
#               " >act <"$HTTPD_ROOT_PATH"/access.log &&
#               test_cmp exp act
#
# failed 13 among 14 test(s)
1..14


--------------6EDB7F9887AB99E95017C1FE
Content-Type: text/plain; charset=UTF-8;
 name="t5561.output"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="t5561.output"

SW5pdGlhbGl6ZWQgZW1wdHkgR2l0IHJlcG9zaXRvcnkgaW4gL2hvbWUvamtydWVnZXIvc291
cmNlcy9naXQvdC90cmFzaCBkaXJlY3RvcnkudDU1NjEtaHR0cC1iYWNrZW5kLy5naXQvCmNo
ZWNraW5nIHByZXJlcXVpc2l0ZTogTk9UX1JPT1QKCm1rZGlyIC1wICIkVFJBU0hfRElSRUNU
T1JZL3ByZXJlcS10ZXN0LWRpciIgJiYKKAoJY2QgIiRUUkFTSF9ESVJFQ1RPUlkvcHJlcmVx
LXRlc3QtZGlyIiAmJgoJdWlkPSQoaWQgLXUpICYmCgl0ZXN0ICIkdWlkIiAhPSAwCgopCnBy
ZXJlcXVpc2l0ZSBOT1RfUk9PVCBvawpleHBlY3Rpbmcgc3VjY2VzczogCgllY2hvIGNvbnRl
bnQgPmZpbGUgJiYKCWdpdCBhZGQgZmlsZSAmJgoJZ2l0IGNvbW1pdCAtbSBvbmUgJiYKCglt
a2RpciAiJEhUVFBEX0RPQ1VNRU5UX1JPT1RfUEFUSC9yZXBvLmdpdCIgJiYKCShjZCAiJEhU
VFBEX0RPQ1VNRU5UX1JPT1RfUEFUSC9yZXBvLmdpdCIgJiYKCSBnaXQgLS1iYXJlIGluaXQg
JiYKCSA6ID5vYmplY3RzL2luZm8vYWx0ZXJuYXRlcyAmJgoJIDogPm9iamVjdHMvaW5mby9o
dHRwLWFsdGVybmF0ZXMKCSkgJiYKCWdpdCByZW1vdGUgYWRkIHB1YmxpYyAiJEhUVFBEX0RP
Q1VNRU5UX1JPT1RfUEFUSC9yZXBvLmdpdCIgJiYKCWdpdCBwdXNoIHB1YmxpYyBtYXN0ZXI6
bWFzdGVyICYmCgoJKGNkICIkSFRUUERfRE9DVU1FTlRfUk9PVF9QQVRIL3JlcG8uZ2l0IiAm
JgoJIGdpdCByZXBhY2sgLWEgLWQKCSkgJiYKCgllY2hvIG90aGVyID5maWxlICYmCglnaXQg
YWRkIGZpbGUgJiYKCWdpdCBjb21taXQgLW0gdHdvICYmCglnaXQgcHVzaCBwdWJsaWMgbWFz
dGVyOm1hc3RlciAmJgoKCUxPT1NFX1VSTD0kKGZpbmRfZmlsZSBvYmplY3RzLz8/KSAmJgoJ
UEFDS19VUkw9JChmaW5kX2ZpbGUgb2JqZWN0cy9wYWNrLyoucGFjaykgJiYKCUlEWF9VUkw9
JChmaW5kX2ZpbGUgb2JqZWN0cy9wYWNrLyouaWR4KQoKW21hc3RlciAocm9vdC1jb21taXQp
IGNhODc5YWRdIG9uZQogQXV0aG9yOiBBIFUgVGhvciA8YXV0aG9yQGV4YW1wbGUuY29tPgog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgZmls
ZQpJbml0aWFsaXplZCBlbXB0eSBHaXQgcmVwb3NpdG9yeSBpbiAvaG9tZS9qa3J1ZWdlci9z
b3VyY2VzL2dpdC90L3RyYXNoIGRpcmVjdG9yeS50NTU2MS1odHRwLWJhY2tlbmQvaHR0cGQv
d3d3L3JlcG8uZ2l0LwpUbyAvaG9tZS9qa3J1ZWdlci9zb3VyY2VzL2dpdC90L3RyYXNoIGRp
cmVjdG9yeS50NTU2MS1odHRwLWJhY2tlbmQvaHR0cGQvd3d3L3JlcG8uZ2l0CiAqIFtuZXcg
YnJhbmNoXSAgICAgIG1hc3RlciAtPiBtYXN0ZXIKW21hc3RlciBiMjNlYzg5XSB0d28KIEF1
dGhvcjogQSBVIFRob3IgPGF1dGhvckBleGFtcGxlLmNvbT4KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQpUbyAvaG9tZS9qa3J1ZWdlci9zb3VyY2Vz
L2dpdC90L3RyYXNoIGRpcmVjdG9yeS50NTU2MS1odHRwLWJhY2tlbmQvaHR0cGQvd3d3L3Jl
cG8uZ2l0CiAgIGNhODc5YWQuLmIyM2VjODkgIG1hc3RlciAtPiBtYXN0ZXIKb2sgMSAtIHNl
dHVwIHJlcG9zaXRvcnkKCmV4cGVjdGluZyBzdWNjZXNzOiAKCUdFVCByZWZzL2hlYWRzL21h
c3RlciAiNDA0IE5vdCBGb3VuZCIKCm5vdCBvayAyIC0gZGlyZWN0IHJlZnMvaGVhZHMvbWFz
dGVyIG5vdCBmb3VuZAojCQojCQlHRVQgcmVmcy9oZWFkcy9tYXN0ZXIgIjQwNCBOb3QgRm91
bmQiCiMJCg==
--------------6EDB7F9887AB99E95017C1FE
Content-Type: application/gzip;
 name="trash directory.t5561-http-backend.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="trash directory.t5561-http-backend.tar.gz"

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
TB+H3/9iFv1/ov1/8OUY+8/hMobo4wj7n4vy/42mHHv/+cLUgX2Qkf+g/O/FcP7nUjET+f+N
pFRzebM2PVOemcnPZHIYR7KWKdbyOb1ULxqZmTrsWzGXyRgRI/jKLEfDfw5LOiwLeAT+r1Qu
RPR/FOV4+49auMFAcITzv5QrR/s/inIf9l/HYK4YDNbdp4+B539v/t8yyn/R+f/gy33YfzQI
7Lf1VAbuf6kU5v9KxUj/O5KySvacZH66kC0Vpo3qdDWXK5j5bEHPzGR1Y7qWLwN/mMkWpkt1
2LYUvq1FzOArptwH/KeXDzoEDk3/85lSsRzh/yjK8fbfLDwo/U8m4v9HUlLpVPqJC469ecGy
bz2gPgL4T3sd+jeTLWa6YCGTzRbLgP8XHtB4uoraf/R0O+i9Qb+/TMux8b9Ym6kBv1YyCgUz
k8+Va9k6PMjP6OVCrZiZzudLmWL+oOzwUXmYZRT7j6Vw0PmfC/t/ZYu5SP4bSbn76DNf+fLK
pUztX6W/fD75Xx575Kf/yqtjD3tQURlZOR7+V3MPiP/LliP930hKxP9F/N+x8H848+HDnmZU
9imj2f+D+b9c2P83nyX7X8T/Pfhy99F3ff13tMeyP/bqm3986kt/9tc++MGvvf6Nn3j7e943
/8Rnvvmxm199PPbi//7oG/9j5d99/wufX03+93+/sLT+g3/5up/9xMW33vrwl88+87bxP/rg
xb9j/8zyt177E6vv/fif/sqrfmRz73zjE2uXfurTn/0fb5y89Jvfiv/GJ983/vdj7/n+d//D
t26+/i9P/9wLmd97/3/++Ht3brwtee0D//Bvnz3zN35tfeXxv7X855Xy9OfH3u/+1edf3Ey+
+I9/8fWND5x5zcNen1d6OR7+F7IPiv/LRf5/IykR/xfxf8fC/2LZKNUL5XptulquVQvFYr1a
L9Wz0/zUNAozekkfCSZH5QhlFPs/UP9XCvl/5nO5iP8bTbn76Mmppy+uZUrVTCEDjPfbzr/w
1SXz7o/nn0p+7xff9BsvfuGX3534pf/z6sKHf/1bjz7y6hs/+rWHPeCo3NdyPPxHb5AH4/+X
je7/jKS8JPi/UjHM/5UyxYj/G0W5D/h/OAcyy7j7sOccFb+MYv8H8H+5XDj+N/B/0f2f0ZT/
116pwT+PDXjt0egTfaIPfR47xudVL9XPazunn3y3+amf+gshPrP8xN23W7/z9Lu+8u4PfftW
63HjzEdffOGF9t+7+Xvvjf3uNzcq37j4J7VK532p/ONv+5+rf/AT/+17P/ovPm584P/e+keX
PvyxN0Fb74HP6+DzW9MLxvs+95mJ//qGj/3NT7+3/N2ff8Nf//6jj26ce/QH7/2jtU999UO/
+8v/6/d/87e/9G9+8EhUHlp5afD/pV7+vxTx/6MoI+f/8e2HPemoeOUlwP9n8vl8L/8fxf8f
SVldWHzmEcmb/JJ29yPvemFB+2Lmx971h3vL2XsLb/23F+JPPv6lz37uG6+68Mdv+JHa07/w
nT/99Bv+04s/c/pNv/2zX33k7Od+8lVnrXe89ld/5fEf/7M3JD525v3f++Q/f837vvuDNeef
fv6nU82/OPdPPv/1b3/ok+/+9Ls/8lvf+bvnP/jN/KeaH/1w8Q9uffax105/4faX/+Qf/Ny3
U6e/tvfIm76Y1T722N2P5ANK6M/9pNP5xp9f/8ya9asf/fWb33nh5//ZF1e+/dgjv/b7r/vK
9N2PPPP1f31y6Wsn//CxR/7SN171mn6sxsNe2pdFORr+nz+7cGb4PgLn/z7+36H8H7l8CeO/
RPj/4EvLrFdETziX6ILnD0sZAv8xZOKx+hiI/5nw/e9MIRPl/x5JcTBBQ4TuP7RlCPx3OscU
fAfjf9j+ixHAIvyPSlSiEpWoRCUqUYlKVKISlahEJSpRiUpUjlv+PxpS0Y8A4AEA
--------------6EDB7F9887AB99E95017C1FE--
