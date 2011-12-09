From: Joshua Redstone <joshua.redstone@fb.com>
Subject: Re: Debugging git-commit slowness on a large repo
Date: Fri, 9 Dec 2011 00:17:55 +0000
Message-ID: <CB069308.2C9DD%joshua.redstone@fb.com>
References: <CB069000.2C9C6%joshua.redstone@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?iso-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Tomas Carnecky <tom@dbservice.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 01:19:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYoB5-0003ma-Lp
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 01:19:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238Ab1LIAS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 19:18:59 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42829 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751226Ab1LIAS6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Dec 2011 19:18:58 -0500
Received: from pps.filterd (m0004060 [127.0.0.1])
	by mx0b-00082601.pphosted.com (8.14.4/8.14.4) with SMTP id pB9094FZ028923;
	Thu, 8 Dec 2011 16:18:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=from : to : cc : subject :
 date : message-id : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=+cZvd4lHl0lfLub5Jg1ihrFYyqTz4ac7XiBOsx6Kyyc=;
 b=jgiLudwKM+6Ui3WlazFSiz8P9Zt5lAekwiWQTwVVtly/UfTOAej23DvRuQHLJ51ok+iT
 NpGFpP5WLrcwiGFg8NRKdhd+peRpYT3ukgJ0Ii3ewAcB0XcFwvBzYY01q/LPBDLfq00d
 ct/hOA/BPN5sWctnRRqE2JrxWrzDUfqEjmA= 
Received: from mail.thefacebook.com (corpout1.snc1.tfbnw.net [66.220.144.38])
	by mx0b-00082601.pphosted.com with ESMTP id 11k55mr5ju-3
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 08 Dec 2011 16:18:02 -0800
Received: from SC-MBX02-5.TheFacebook.com ([fe80::9dc2:cfe6:2745:44cc]) by
 sc-hub04.TheFacebook.com ([192.168.18.212]) with mapi id 14.01.0289.001; Thu,
 8 Dec 2011 16:17:56 -0800
Thread-Topic: Debugging git-commit slowness on a large repo
Thread-Index: AQHMsUiE0jGAmaiuRkyp0eiAE6mrR5XJxzCAgAXbCACAAIurgIAA1D+AgAC14ACAAPMrAIAAAj6A
In-Reply-To: <CB069000.2C9C6%joshua.redstone@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.13.0.110805
x-originating-ip: [192.168.18.252]
Content-ID: <EFC7224817658A42BA1B5945D75AB3C1@fb.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.5.7110,1.0.211,0.0.0000
 definitions=2011-12-08_09:2011-12-08,2011-12-08,1970-01-01 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186603>

Btw, I also tried doing some very poor-man's profiling on "git commit"
without any of the readtree/writetree/updateindex commands.

Around 50% of the time was in (bottom few frames may have varied)

#1  0x00000000004c467e in find_pack_entry (sha1=0x1475a44 ,
e=0x7fff2621f070) at sha1_file.c:2027
#2  0x00000000004c57b0 in has_sha1_file (sha1=0x7fe2cd9c7900 "00") at
sha1_file.c:2567   
                   
                 
#3  0x000000000046e4af in update_one (it=<value optimized out>,
cache=<value optimized out>, entries=<value optimized out>, base=<value
optimized out>, baselen=<value optimized out>, missing_ok=<value optimized
out>, dryrun=0) at cache-\
tree.c:333         
                   
                   
            
#4  0x000000000046e278 in update_one (it=<value optimized out>,
cache=<value optimized out>, entries=<value optimized out>, base=<value
optimized out>, baselen=<value optimized out>, missing_ok=<value optimized
out>, dryrun=0) at cache-\
tree.c:285         
                   
                   
            
#5  0x000000000046e278 in update_one (it=<value optimized out>,
cache=<value optimized out>, entries=<value optimized out>, base=<value
optimized out>, baselen=<value optimized out>, missing_ok=<value optimized
out>, dryrun=0) at cache-\
tree.c:285         
                   
                   
            
#6  0x000000000046e278 in update_one (it=<value optimized out>,
cache=<value optimized out>, entries=<value optimized out>, base=<value
optimized out>, baselen=<value optimized out>, missing_ok=<value optimized
out>, dryrun=0) at cache-\
tree.c:285         
                   
                   
            
#7  0x000000000046e278 in update_one (it=<value optimized out>,
cache=<value optimized out>, entries=<value optimized out>, base=<value
optimized out>, baselen=<value optimized out>, missing_ok=<value optimized
out>, dryrun=0) at cache-\
tree.c:285         
                   
                   
            
#8  0x000000000046e278 in update_one (it=<value optimized out>,
cache=<value optimized out>, entries=<value optimized out>, base=<value
optimized out>, baselen=<value optimized out>, missing_ok=<value optimized
out>, dryrun=0) at cache-\
tree.c:285         
                   
                   
            
#9  0x000000000046e869 in cache_tree_update (it=<value optimized out>,
cache=<value optimized out>, entries=dwarf2_read_address: Corrupted DWARF
expression.        
                 
) at cache-tree.c:379
                   
                   
            
#10 0x000000000041cade in prepare_to_commit (index_file=0x781740
".git/index", prefix=<value optimized out>, current_head=<value optimized
out>, s=0x7fff26220d00, author_ident=<value optimized out>) at
builtin/commit.c:866
#11 0x000000000041d891 in cmd_commit (argc=0, argv=0x7fff262213a0,
prefix=0x0) at builtin/commit.c:1407
                   
                   
#12 0x0000000000404bf7 in handle_internal_command (argc=4,
argv=0x7fff262213a0) at git.c:308
                   
                   
#13 0x0000000000404e2f in main (argc=4, argv=0x7fff262213a0) at git.c:512
                   
                   
            
 


And 30% of the time was in:

#0  0x00000034af2c34a5 in _lxstat () from /lib64/libc.so.6
                   
                   
            
#1  0x00000000004abe0f in refresh_cache_ent (istate=0x780940,
ce=0x7f8462a34e40, options=0, err=0x7fff6dd9f588) at
/usr/include/sys/stat.h:443
                   
#2  0x00000000004ac1a0 in refresh_index (istate=0x780940, flags=<value
optimized out>, pathspec=<value optimized out>, seen=<value optimized
out>, header_msg=0x0) at read-cache.c:1133
                   
#3  0x000000000041b60a in refresh_cache_or_die (refresh_flags=<value
optimized out>) at builtin/commit.c:331
                   
                  
#4  0x000000000041bc39 in prepare_index (argc=0, argv=0x7fff6dda0310,
prefix=0x0, current_head=<value optimized out>, is_status=<value optimized
out>) at builtin/commit.c:414
                 
#5  0x000000000041d878 in cmd_commit (argc=0, argv=0x7fff6dda0310,
prefix=0x0) at builtin/commit.c:1403
                   
                   
  


Josh


On 12/8/11 4:09 PM, "Joshua Redstone" <joshua.redstone@fb.com> wrote:

>On 12/7/11 5:39 PM, "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> wrote:
>
>>On Thu, Dec 8, 2011 at 5:48 AM, Joshua Redstone <joshua.redstone@fb.com>
>>wrote:
>>> Hi Duy,
>>> Thanks for the documentation link.
>>>
>>> git ls-files shows 100k files, which matches # of files in the working
>>> tree ('find . -type f -print | wc -l').
>>
>>Any chance you can split it into smaller repositories, or remove files
>>from working directory (e.g. if you store logs, you don't have to keep
>>logs from all time in working directory, they can be retrieved from
>>history).
>
>It's not really feasible to split it into smaller repositories.  In fact,
>we're expecting it to grow between 3x and 5x in number of files and number
>of commits.
>
>>
>>> I added a 'git read-tree HEAD' before the git-add, and a 'git
>>>write-tree'
>>> after the add.  With that, the commit time slowed down to 8 seconds per
>>> commit, plus 4 more seconds for the read-tree/add/write-tree ops.  The
>>> read-tree/add/write-tree each took about a second.
>>
>>read-tree destroys stat info in index, refreshing 100k entries in
>>index in this case may take some time. Try this to see if commit time
>>reduces and how much time update-index takes
>>
>>read-tree HEAD
>>update-index --refresh
>>add ....
>>write-tree
>>commit -q
>
>I added the "update-index --refresh" and the time for commit became more
>like 0.6 seconds.
>In this setup: read-tree takes ~2 seconds, update-index takes ~8 seconds,
>git-add takes 1 to 4 seconds, and write-tree takes less than 1 second.
>
>>
>>> As an experiment, I also tried removing the 'git read-tree' and just
>>> having the git-write-tree.  That sped up commits to 0.6 seconds, but
>>>the
>>> overall time for add/write-tree/commit was still 3 to 6 seconds.
>>
>>overall time is not really important because we duplicate work here
>>(write-tree is done as part of commit again). What I'm trying to do is
>>to determine how much time each operation in commit may take.
>>-- 
>>Duy
>
