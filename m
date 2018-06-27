Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9327F1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 07:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933123AbeF0Hy7 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 27 Jun 2018 03:54:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49086 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933038AbeF0Hy5 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 27 Jun 2018 03:54:57 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5R7sG5e076251
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 03:54:57 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.90])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jv64h1e7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 03:54:57 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <git@vger.kernel.org> from <GROEGES@uk.ibm.com>;
        Wed, 27 Jun 2018 07:54:56 -0000
Received: from us1a3-smtp08.a3.dal06.isc4sb.com (10.146.103.57)
        by smtp.notes.na.collabserv.com (10.106.227.141) with smtp.notes.na.collabserv.com ESMTP;
        Wed, 27 Jun 2018 07:54:53 -0000
Received: from us1a3-mail97.a3.dal06.isc4sb.com ([10.146.21.232])
          by us1a3-smtp08.a3.dal06.isc4sb.com
          with ESMTP id 2018062707545273-174479 ;
          Wed, 27 Jun 2018 07:54:52 +0000 
X-Disclaimed: 1
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
In-Reply-To: 
References: 
Subject: Use of new .gitattributes working-tree-encoding attribute across different
 platform types
From:   Steve Groeger <GROEGES@uk.ibm.com>
To:     git@vger.kernel.org
Date:   Wed, 27 Jun 2018 07:54:52 +0000
X-Mailer: IBM iNotes ($HaikuForm 1011.1) | IBM Domino Build
 SCN1809300_20180403T0021_FP2 April 18, 2018 at 18:02
X-LLNOutbound: False
X-TNEFEvaluated: 1
x-cbid: 18062707-9717-0000-0000-0000080DB41C
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.415652; ST=0; TS=0; UL=0; ISC=; MB=0.015596
X-IBM-SpamModules-Versions: BY=3.00009262; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052964; UDB=6.00539845; IPR=6.00830888;
 BA=6.00006022; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00021878; XFM=3.00000015;
 UTC=2018-06-27 07:54:55
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2018-06-27 06:07:50 - 6.00008627
x-cbparentid: 18062707-9718-0000-0000-0000E40CBB80
Message-Id: <OF5D40FE06.C18CD7CD-ON002582B9.002B7A02-002582B9.002B7A07@notes.na.collabserv.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, 

Sorry for incomplete post earlier. Here is the full post:


In the latest version of git a new attribute has been added, working-tree-encoding. The release notes states: 

'The new "working-tree-encoding" attribute can ask Git to convert the
   contents to the specified encoding when checking out to the working
   tree (and the other way around when checking in).'
 We have been using this attribute on our z/OS systems using a version of git from Rocket software to convert files to EBCDIC for quite a while now. On other platforms (Linux, AIX etc) git ignored this attribute and therefore left the files in ASCII.

We have common code that is supposed to be usable across different platforms and hence different file encodings. With the full support of the working-tree-encoding in the latest version of git on all platforms, how do we have files converted to different encodings on different platforms?
I could not find anything that would allow us to say 'if platform = z/OS then encoding=EBCDIC else encoding=ASCII'.   Is there a way this can be done?
 
 
  
 
Thanks
 Steve Groeger
 Java Runtimes Development
 IBM Hursley
 IBM United Kingdom Ltd
 Tel: (44) 1962 816911 Mobex: 279990 Mobile: 07718 517 129
 Fax (44) 1962 816800
 Lotus Notes: Steve Groeger/UK/IBM
 Internet: groeges@uk.ibm.com  
   
 
Unless stated otherwise above:
 IBM United Kingdom Limited - Registered in England and Wales with number 741598.
 Registered office: PO Box 41, North Harbour, Portsmouth, Hampshire PO6 3AU      
Unless stated otherwise above:
IBM United Kingdom Limited - Registered in England and Wales with number 741598. 
Registered office: PO Box 41, North Harbour, Portsmouth, Hampshire PO6 3AU

