From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH] clone: add `--shallow-submodules` flag
Date: Fri, 11 Mar 2016 16:56:33 -0800
Message-ID: <CAGZ79kYc1WR9CTBi1F3KpLaYRUSxNPQkQ2jk+P09pshR3jG8aw@mail.gmail.com>
References: <1457739683-1972-1-git-send-email-sbeller@google.com>
	<xmqqa8m4a5nx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 12 01:56:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeXrH-0006Mz-5b
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 01:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbcCLA4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 19:56:36 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:35185 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbcCLA4e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 19:56:34 -0500
Received: by mail-io0-f170.google.com with SMTP id g203so165639827iof.2
        for <git@vger.kernel.org>; Fri, 11 Mar 2016 16:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Ed8ilqKudTkPl0wzI8eQsbfXWRz+J+L1jR7r1O9FPc0=;
        b=bK//KSdBCrwJcYzQLbnDggXo1qrKYrzp7o3rIHpw4+YjtwXNN1ba+lkU/flk3fZaRU
         HmpBokJ/nff6Awj1LNKxceDlAEFQDaeMBtHGa93rCs78jGmxBPE2bjCILyj+OA6T0foy
         2NnBt1aoP9lIF54ofA3W4mGODLvOkDgJbOEvQMwatRfxqJ1j33McIXXmYVOp2goJJK1i
         wX+9aTM3GfpukUIMCNIZSnC5lFCVao/Uww1AXzOfm1oBha+E+Q9ZrQeBPwD8GXY07R4c
         3dOuNK/0h+26qRbuC7Pjxzj64cG3xKjJ6XfRCIjimOCgM0n5D9TEaF67po6Yxy0pqpil
         Honw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Ed8ilqKudTkPl0wzI8eQsbfXWRz+J+L1jR7r1O9FPc0=;
        b=Ri+8fS5BjRN8+ujeHc7cTA6q6qqpCx05LRg81e4+QSRjvlDlKbUy1GOV64z2jf+aVg
         ZgooO1n59o1tvrvwsUaigEgusmuTwrrte8PCfhD+Sofpw5BDe8SJek5ty449VJPhHHaR
         s+BVLmi4R1UvAyEGHbUZYsxWayw/FP3+Y+YWq4VZ4bEABc6hSUfjGiBCuX6n8eyKNr3s
         k9VK0XeIkeJ23SY9vOiBuEyPYRctPy2YBOpaU7+Hf0+N1jUYctQMgChACXheArfHsR4y
         6B8W9seFgvA/ZuEtMXXQRfJ4un7QaHG9ZDOTwDjiB6L8Yx9YO3XxuNxZZizTaZw1o7mp
         Cikw==
X-Gm-Message-State: AD7BkJIk3cCzg4mBZgzONF7DwrWjt55IOSjWvfHH3vNk/fUTuuYsF3fuDuePJmEgHjq+kyBctS6wnok/eZrYqQZx
X-Received: by 10.107.158.138 with SMTP id h132mr13440948ioe.174.1457744193839;
 Fri, 11 Mar 2016 16:56:33 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Fri, 11 Mar 2016 16:56:33 -0800 (PST)
In-Reply-To: <xmqqa8m4a5nx.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288722>

On Fri, Mar 11, 2016 at 4:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> When creating a shallow clone of a repository with submodules, the depth
>> argument does not influence the submodules, i.e. the submodules are done
>> as non-shallow clones. It is unclear what the best default is for the
>> depth of submodules of a shallow clone, so we need to have the possibility
>> to do all kinds of combinations:
>>
>> * shallow super project with shallow submodules
>>   e.g. build bots starting always from scratch. They want to transmit
>>   the least amount of network data as well as using the least amount
>>   of space on their hard drive.
>> * shallow super project with unshallow submodules
>>   e.g. The superproject is just there to track a collection of repositories
>>   and it is not important to have the relationship between the repositories
>>   intact. However the history of the individual submodules matter.
>> * unshallow super project with shallow submodules
>>   e.g. The superproject is the actual project and the submodule is a
>>   library which is rarely touched.
>>
>> The new switch to select submodules to be shallow or unshallow supports
>> all of these three cases.
>
> I think something like this is necessary to prime the well, but the
> more important (and intereseting) bit is how this shallowness is
> going to be maintained and carried forward across the future updates
> to the top-level supermodule.  A submodule that was cloned at depth=1
> initially along with its supermodule when the latter was initially
> cloned does not have to be indefinitely kept at depth=1, and there
> would be a lot of creative ways to make it useful, but the creative
> and useful logic would need a piece of information to tell the
> future "submodule update" why the submodule repository is shallow to
> take into account, I would imagine.
>
> It is somewhat curious that there is no hint left in the submodule
> repositories (e.g. their configfile) that they are originally
> created with an explicit user request "I said that I want these
> submodules to be cloned with depth=1", from that point of view.

Why is it interesting for submodules but not for standard repositories?
If I clone a repository without submodules, it is also not recorded
that I cloned with an explicit depth=1. If you fetch, you may end up with
a deeper history as git fetch doesn't do a "reshallow" to the configured
depth.

As the depth can easily change I view depth as a measure which is
only valid at moment in time, after the operation succeeded we rather
want to talk about the cut off points which were introduced by the
shallow operation? And these are kept as is by default which is sane.
