From: Adam Kurkiewicz <popantrop@gmail.com>
Subject: Re: How to organize multiple small reusable components with Git?
Date: Sat, 25 Jul 2015 19:31:50 +0100
Message-ID: <CAA2SmNdXUdcTrLLg9iMMW6+N6h_XgA02w6XWMvncWYp=pdX61A@mail.gmail.com>
References: <CAMDZmAEf4afqhR4WT4e-dXjY5OWUSoE_WVGj1ztW-pA=ym9e3A@mail.gmail.com>
	<CAA2SmNeRVMUu10QRAWJMnk=_qmkAcCYWweNp8sD7k+A4V9v7uA@mail.gmail.com>
	<CAMDZmAGBdpjnjJtNH9Nw9E_pATtgnOY_tq3QbQqUas-BM=ss=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, neac03@gmail.com
To: Bing Tian <tianbing1212@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 20:32:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJ4Ey-00036j-KW
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jul 2015 20:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbbGYSbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2015 14:31:53 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37682 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755020AbbGYSbw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2015 14:31:52 -0400
Received: by wibud3 with SMTP id ud3so68734638wib.0
        for <git@vger.kernel.org>; Sat, 25 Jul 2015 11:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HRpOIWIQ4tkJD+FxzY0nvZNNh8jtghwlGFtLefhcY+E=;
        b=rGOSjGnvh/S98XPH5L5GvofFiRmW1nZJM4ivl4sULxiR/gNl9E7cB3uOZJly6GHQKC
         ErbeNYJX2GNVfhwaFgUjMpPWmDu4uEnfEmpPRxNvcFRvXYIlt9ERc2Ckh0HvvWrSs8at
         otdWDnhPmumXfb4RvB33K1axVJLx8sZbOBSWGIzcPyuYrP8/KZcm/BqwoWMHg8lIYB2/
         ekyNgrDjFLdfs91zY/2YxDAiIn+8oizTZPPK2XFJzcRy+vI3VhRLKXKs93OwRc92138G
         Q/yYNHHQdso92RkB5xSrk4zdSKYaXNnWzljRQV9M0J7dlq1iPO4vhzEBWLfWdJs0JkCx
         DlEg==
X-Received: by 10.180.79.4 with SMTP id f4mr8544264wix.83.1437849110682; Sat,
 25 Jul 2015 11:31:50 -0700 (PDT)
Received: by 10.27.203.193 with HTTP; Sat, 25 Jul 2015 11:31:50 -0700 (PDT)
In-Reply-To: <CAMDZmAGBdpjnjJtNH9Nw9E_pATtgnOY_tq3QbQqUas-BM=ss=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274615>

Hi Bing,
I don't think the approach you're outlining in your most recent e-mail
is going to work particularly well for you. See my replies in-line.

I have devised a solution that should work much better for you, it's a
tiny bash script and a set of naming conventions for repository
branches. I've described it in detail and implemented a toy example on
github:

https://github.com/picrin/git-components/blob/master/README.md

FYI, when you click reply button, you have to click reply all or
otherwise your e-mail doesn't go to the mailing list but just to me
personally.

Inline responses follow:

> Thanks for your kindly reply, which helps a lot.
> I plans a neutral approach for my case now.
> (1) create a "Components" git repo to hold all kinds of components,
> each component in a directory.
> As for each component, use regular git way to manage the version.
> Accordingly there's not Version1 (Dir) or Version2(Dir), to follow Git
> practice.

This way you can't version each component independently -- you have
one global history, which means a lot of noise per component.

> (2) create another publication (release) server for all versions of
> all components. (the server is not managed in git)
> The publication server is read only, and every one can get
> component(s) they need for further use.

It's not clear to me how your publication server would be able to pick
up from your messy history the correct versions of multiple
components. Also, some of your clients might want to sit on an older
(or more stable, or otherwise customised) version of a given
component, or want a narrower set of components, so
one-history-for-all clearly doesn't work for you.

Besides, for publications git has already got something built in, read
up about git-archive.

Adam

>
>
>
> 2015-07-23 20:57 GMT+08:00 Adam Kurkiewicz <popantrop@gmail.com>:
>> Hi Bing,
>> You seem to be describing a very interesting problem, similar to what I
>> often run into in my day job. In my day job I'm composing multiple java
>> microservices into a single application. We have about 7 microservices, but
>> this number will probably grow to more than 10 before the application is
>> feature-complete. Because microservices are mutually independent and unaware
>> of each other (however, they _do_ share knowledge of message formats
>> exchanged on the message queue), we have a very acute problem of composing
>> entire system together. The problem is two-fold:
>>
>> 1) how do you know which set of the versions of components gives you a
>> working system?
>> 2) how do you keep track of a record of [the sets of the versions of
>> components] which give you a working system?
>>
>> Part 1) is much more difficult than part 2). Although part 1) lies outside
>> of the scope of version control I'd like to pay your attention to it
>> nonetheless. In principle with 10 versions of 10 components you have 10
>> billion possibly valid configurations of the system. In such circumstance it
>> is very helpful to use such good SE practices like depcrecation warnings,
>> semantic versioning and clean distinction between interface and its
>> implementation. You can also do it the linux kernel way by simply never
>> introducing backwards-incompatible changes. If you want to read up about
>> semantic versioning, here's the link to the standard:
>> http://semver.org/
>>
>> Part 2) is really what git can help you with:
>>
>> One way to deal with this is to manage each component in a separate git
>> repository (thus version each component separately) and have a thin parent
>> project, which imports all other projects as submodules. The way submodules
>> work is through storing each submodule as a separate directory. You can go
>> to each of the submodule directories, checkout a particular commit which you
>> want to be marked as a part of your system and mark each component with
>> usual command "git add <submodule_dir>". That obviously assumes that you've
>> already solved Part 1) and you know what versions of components give you a
>> working system. You can repeat this process for each submodule and once
>> you're happy commit the result in the parent project and push to the remote.
>> You can also do usual git things such as tags for example.
>>
>> I'm not sure how much I like this solution though: having multiple
>> repositories seems to be an overkill for most cases. Behaviour of submodules
>> has been startling on a few occasions (for example `git submodule update`
>> can actually take you to back in time rather than forward). I've also
>> experienced several peculiar and difficult to pinpoint issues on windows.
>> Although I haven't used it much, git subtrees seems to be much nicer
>> alternative. You can read about them here:
>> http://blogs.atlassian.com/2013/05/alternatives-to-git-submodule-git-subtree/
>>
>> As to your original idea about having multiple separate directories, I'm not
>> sure I like it at all. By splitting the versions of your components into
>> separate directories you loose a lot of benefits of version control. With
>> multiple directories you won't be able to apply hotfixes to multiple
>> versions of the component for example without rewriting the logic of
>> cherry-pick.
>>
>> Cheers,
>> Adam
>>
>>
>> 2015-07-23 12:20 GMT+01:00 Bing Tian <tianbing1212@gmail.com>:
>>>
>>> I am using git to manage some circuit components.
>>> Each component is small and I plan to create a "component" project in
>>> Git to hold all the small components.
>>> Each component may have several released version, such as
>>> Comonent1_V1, Component1_V2, Comonent2_V1, Component2_V2.
>>> And for future reuse, I may use Component1_V1+Component2_V2, or
>>> Component1_V2+Component2_V1 in my local directory.
>>> So, I plan to create several directories, each for one version of one
>>> component. I looks like followings:
>>> Components
>>>      |------Component1
>>>      |                 |------------------Version1(Dir)
>>>      |                 |------------------Version2(Dir)
>>>      |-------Component2
>>>                        |------------------Version1(Dir)
>>>                        |------------------Version2(Dir)
>>>
>>> I want to know, is the above a suitable way in Git?   Are there some
>>> risks for my project and Git?
>>> Any suggestions to cover this case in Git?
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
