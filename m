From: Guilherme <guibufolo@gmail.com>
Subject: Git clone sends first an empty authorization header
Date: Sat, 5 Mar 2016 10:21:31 +0530
Message-ID: <CAMDzUty+O2Gu7o4bFib71AaNZn647WQ1v7ceiznHOs7-xwZGUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 05 05:57:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ac4Gx-0001vA-J9
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 05:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758765AbcCEEwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 23:52:13 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:35056 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757051AbcCEEwM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 23:52:12 -0500
Received: by mail-vk0-f41.google.com with SMTP id e6so73486454vkh.2
        for <git@vger.kernel.org>; Fri, 04 Mar 2016 20:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=f9AIHbVUu1qYvZpI8qv4kVzebF8xhWDK7OIKHJITQu8=;
        b=HggHuQ2WKVqk4eJR4ezlGu6rjT3Dc+D1z4nynLoHnZFhD/qESi2LyUWvpG2ti7HAuU
         LllrAuxVWZs+ARVPOqTafSb1sqrl/dSX6u7bzwjVjJ/DiWSknSSpWT3IXmsStQz8hnh/
         lybAszcx23sl/NMO9Y2r29SFPdtXqKbRRqDHhWbJT0RGtChjG/YFuJMCbPD5yUv4hoM/
         TDYFI24413P1J5NCqFct6cDgJd7OMoUj5cHBWA+LXWDX2WWWykBT11BzecDSxLzoBow2
         E3FAphFxAMgCf97AG4wJP7pJr+ax9QV1y2fIihdGg1m2SPuRDTDIr0+jBvjmYPUXPMq+
         jymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=f9AIHbVUu1qYvZpI8qv4kVzebF8xhWDK7OIKHJITQu8=;
        b=a0h8ySYrXbZK8+oCNkV0oGMKFchq5/V3F5Q2Hy/SJPkcCKBj9cGzsX8dl2fpuKitT0
         Mer52ScPZ+ULsvXgMPWVazoztI79vt2n19VfEWLIt1BFETKqtE6leq6ir5DV5GnQ5Lo5
         BivYWe9sHsCNmmxkstYeVVQ3wPrEiGvAnkIG7ZEg7QQ8KSMvfo7R2MKNtcJ0I9akTbXV
         QwTV+RtnX34bqXSciV4KMoeHFkdKXGMCgEfRPx9UaCZ5m5r+ePyQ0GVARIYTQnIiW4oB
         11Z+8w9JsgnQpNRkMrlMMmGaUd+6Xue8xuNBKIHNsSF4LY5YWOm8eUBhyPBsPDHjdl2n
         v7XA==
X-Gm-Message-State: AD7BkJIWeKc3ViVU8muR+8dbBt2A26fS3CcT261ia8Dfq7fgzlWcnoOEu039+NYiUAwH/y9mgGDpbOJHDVIDmw==
X-Received: by 10.31.52.147 with SMTP id b141mr9540451vka.82.1457153531096;
 Fri, 04 Mar 2016 20:52:11 -0800 (PST)
Received: by 10.31.162.145 with HTTP; Fri, 4 Mar 2016 20:51:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288293>

Hi,

When doing basic authentication using git clone by passing the
username and password in the url git clone will first send a GET
request without the authorization header set.

Am i seeing this right?

This means that if the counterpart allows anonymous cloning but not
pushing and the user provided a wrong usernam/password, it has two
options:

1. Allow the access and leave the user to figure out why he is not able to push.

2. Reply by setting the WWW-Authentication header and see if a
password/username is provided. This has the downside that if no
username and password is provided the user will still get a login
prompt for password and username. Upon entering twice nothing he will
still be able to clone. This can be confusing.

Can this behaviour of git clone (and I guess all the other parts that
do basic auth) be changed to provide the authentication header right
on the first request? Or am I doing/interpreting it wrong?

Thank you.
