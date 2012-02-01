From: "Bryan O'Sullivan" <bryano@fb.com>
Subject: Re: logging disjoint sets of commits in a single command
Date: Wed, 1 Feb 2012 00:27:06 +0000
Message-ID: <CB4DC442.72F%bryano@fb.com>
References: <CB4DC432.72D%bryano@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 01:27:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsO2k-0001sD-Mh
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 01:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755619Ab2BAA1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 19:27:14 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37664 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754021Ab2BAA1M convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 19:27:12 -0500
Received: from pps.filterd (m0004003 [127.0.0.1])
	by mx0b-00082601.pphosted.com (8.14.4/8.14.4) with SMTP id q110Q3ej025820
	for <git@vger.kernel.org>; Tue, 31 Jan 2012 16:27:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=from : to : subject : date
 : message-id : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=na5mA9fv9gAGOptfXXcPKcG+QO9Hrjy37IWnsgYIOg8=;
 b=SofYBRww76z5xwSPLZRXjnc+m6cbPpGQ5r06/lHp5XdmwAvufB5SKuP3zibQiXctYPhB
 DS9RCgbyw8xoH22WK1HufCqHhE+/FNu+BK8C4O7i4g6gM81T1/c9g++pvbB4+Wr2nJkI
 QdBIU7SPd8XmteoG4EX2BcfWUXGxqVI+Lrw= 
Received: from mail.thefacebook.com (corpout1.snc1.tfbnw.net [66.220.144.38])
	by mx0b-00082601.pphosted.com with ESMTP id 12pp7nrbwu-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Tue, 31 Jan 2012 16:27:11 -0800
Received: from SC-MBX02-4.TheFacebook.com ([fe80::e1f0:42de:c867:1385]) by
 sc-hub03.TheFacebook.com ([192.168.18.198]) with mapi id 14.01.0355.002; Tue,
 31 Jan 2012 16:27:06 -0800
Thread-Topic: logging disjoint sets of commits in a single command
Thread-Index: AQHM4Hal0o4/+qLyk0uC5cG4lN8eDZYnLqsA
In-Reply-To: <CB4DC432.72D%bryano@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.18.252]
Content-ID: <7F10E9E4A1FE3046AC376758128C0F81@fb.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.6.7361,1.0.211,0.0.0000
 definitions=2012-01-31_09:2012-01-31,2012-01-31,1970-01-01 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189485>

On 2012-01-31 16:15 , "Bryan O'Sullivan" <bryano@fb.com> wrote:

>I'm trying to use "git log" to display only a handful of commits, where
>the commits are not necessarily linearly related to each other.

And I beautifully fat-fingered the "send" key. Oops.

What I was *going* to say was that it looks like revision.c:limit_list is
(whether intentionally or not) getting in the way of this.

Here's a sample command line against a kernel tree:

git log 373af0c^..373af0c 590dfe2^..590dfe2

I want git to log those two specific commits, but in fact it looks like
limit_list is marking 590dfe2 as UNINTERESTING while processing 373af0c,
and so it gets pruned.

Is there some way around this, or would a patch to fix it be acceptable?
