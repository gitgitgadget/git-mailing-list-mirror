From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: parse-options does not recognize "unspecified" behavior
Date: Thu, 17 Mar 2016 01:21:49 +0530
Message-ID: <CAFZEwPPd2wFqFq2LFEzN2CzhTV6C420SLPcXi1SWE=z2epOYLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 16 20:51:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agHU3-0001e8-CA
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 20:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933743AbcCPTvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 15:51:51 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:33812 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754959AbcCPTvu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 15:51:50 -0400
Received: by mail-yw0-f178.google.com with SMTP id h129so75210401ywb.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 12:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=NQgJrYttCD1pqC9w+3YhkEW4NJ32VhQX3E3UHFAVY6o=;
        b=zJ7J0KEPyI2tSkWlybBQtCcVQgJW+6F5TLPko6Y+ak3cQlMwqvOlqC++TJhwiEUVZc
         4at/LNB5+Gnor6g08JqWOLFrz2iv2qJ2gtXsOwWjmQEG0g1x7l7eB0h0VyoobLDdwp+N
         HZZ/Ndq0oerDCJUkPP/0YD7yph/GMQK5iNxgeXgJOtBqpsTDFeKmiVbE9ZTc+0nxg6f6
         1ZYqP28s1UkxJ7P20z2jYrVb8fYdatlcUyZm2G1/xJ5PBzNwnke9TaUocBTGhDRGXOvz
         abywLaSPNYk8aMML0V/tQW8zjgJiL+u+/J7OOZMiVH/55uv44/R6xpypJCSLulNPUTLx
         JjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NQgJrYttCD1pqC9w+3YhkEW4NJ32VhQX3E3UHFAVY6o=;
        b=eSJt2Zi5r6DW4GkCYfgzl1FNgrg+5Gbdc9TGjHrfV+IuLgSa9Rip1cKbJyUvlzo5T8
         jDpH/o1IO980kXZVepySYXb3pXiKWmfQun9wi5SRklg/d8AAQgnthb1++jYqvqlXZtes
         NF2rS77kvH6mT1X5obGuBECLJpsWmAjaUCsbBmbXHEJeZheoFB8qkfTl49VhcziPo+gR
         xMlOW/ZKZbxh5kdEwymUCO+FuQq0qRmKPN+xCO6BkR7s5QeskAatp4StXJIdR1rh7V1t
         QskCOMF6elb+Lu85tvUIMcSXMc096TZ7Od4EeKqsDthNzuDTVP7bRegCwQMzqqQ2GnNS
         JW3Q==
X-Gm-Message-State: AD7BkJL9zZCNqTpZzK8mGQwWMSZ19anRhVm06dtDqmYksZ8V4dVJ/4eSzZyGUAid0SRRPMSZ4OwEPWMjoDmcJQ==
X-Received: by 10.129.91.6 with SMTP id p6mr2509790ywb.325.1458157909278; Wed,
 16 Mar 2016 12:51:49 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Wed, 16 Mar 2016 12:51:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289027>

Hey!

I noticed that parse-options does not recognize the variable which is
set to -1 so as to denote the "unspecified" value.

I did the following changes in builtin/commit.c (in master branch not
the patch I am working on) :
 - static int verbose = -1
 - introduced a printf statement after parsing the options to print
the value of verbose.

When I ran `git commit` :
 I get the output that verbose is set to -1.

When I ran `git commit -v` :
I get the output that verbose is set to 0.

When I ran `git commit -v -v` :
I get the output that verbose is set to 1.

When I ran `git commit --no-verbose` :
I get the out that verbose is set to 0.

Then I set verbose = -2.
And the output was obtained in a similar format.
 -2 with `git commit`
 -1 with `git commit -v`
  0 with `git commit -v -v`
  0 with `git commit --no-verbose`
  1 with `git commit -v -v -v`

It seems that parse-options just increments the value without
considering the -1 flag to denote "unspecified value".

Is this a bug?
