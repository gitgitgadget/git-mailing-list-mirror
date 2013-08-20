From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Dokumenting api-paths.txt
Date: Tue, 20 Aug 2013 14:59:11 -0700
Message-ID: <20130820215911.GJ4110@google.com>
References: <1376864786-21367-1-git-send-email-stefanbeller@googlemail.com>
 <1376954619-24314-1-git-send-email-stefanbeller@googlemail.com>
 <52136F9C.6030308@kdbg.org>
 <5213DE72.3000308@googlemail.com>
 <20130820213452.GI4110@google.com>
 <5213E240.9080106@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 23:59:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBtxP-000058-O8
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 23:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329Ab3HTV7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 17:59:16 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34955 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178Ab3HTV7P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 17:59:15 -0400
Received: by mail-pa0-f45.google.com with SMTP id bg4so4225pad.4
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 14:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=QSsefQWQh9kVTerTtnMEhBTvlTzkb8ZRzLLnqEnz8xk=;
        b=qONfUlb+2U9RLucwE6ICQhj/zAtOqeGvACNxH8KeG2L6LrwMbJXueyddPBd7n348T5
         236S2G/Lcv/uR1Fq1Fa2Mkm3PJzuJ44Aiw1w/r+SoCUY/13uj+UkHNE5PsjEUfSfnZ3m
         eWghHRBpQ9zdlt8CYUzhajAjo6eKXm0mhmLPPpPETHbFCf/oNN3TIk0+Yai2iYI4U8RR
         BsZtHZ/Mp2flCmT3jcQ58DyzEgt14Gx8SkgmXG4bNCc/yiZERb93fid1Vrg5PWuIwNIE
         qFCddl8LTOu7e0btHO1NRH1dlEaYI/4U1FLz2ymMNM5iMDtHcvvsn6WhOm6bU9IVPwv9
         5OWQ==
X-Received: by 10.66.219.41 with SMTP id pl9mr4623864pac.187.1377035954970;
        Tue, 20 Aug 2013 14:59:14 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xs1sm5903804pac.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 14:59:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5213E240.9080106@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232653>

Stefan Beller wrote:
>>> On 08/20/2013 03:31 PM, Johannes Sixt wrote:
>>>> Stefan Beller wrote:

>>>>> +    packdir = mkpathdup("%s/pack", get_object_directory());
>>>>> +    packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, getpid());
>>>>
>>>> Should this not be
>>>>
>>>>     packdir = xstrdup(git_path("pack"));
>>>>     packtmp = xstrdup(git_path("pack/.tmp-%d-pack", getpid()));
[...]
> So if I have 
> 	packdir = xstrdup(git_path("pack"));
> 	...
> 	path = git_path("%s/%s", packdir, filename)
>
> This produces something as:
> .git/.git/objects/pack/.tmp-13199-pack-c59c5758ef159b272f6ab10cb9fadee443966e71.idx
> definitely having one .git too much.

The version with get_object_directory() was right.  The object
directory is not even necessarily under .git/, since it can be
overridden using the GIT_OBJECT_DIRECTORY envvar.

> Also interesting to add would be that git_path operates in the
> .git/objects directory?

git_path is for resolving paths within GIT_DIR, such as
git_path("config") and git_path("COMMIT_EDITMSG").

Jonathan
