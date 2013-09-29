From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 01/44] Add support for ruby commands
Date: Sat, 28 Sep 2013 23:47:28 -0500
Message-ID: <CAMP44s0++uqqDc0YKO0bxkP3WfLRgVKYYfTVxJod_Kf23i=5zg@mail.gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
	<1380405849-13000-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0m+LW-R-WJ6DmQkf1GKbCgvpzaGc2=rCNnmiPkf8x_qLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 29 06:47:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ8us-00010V-7P
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 06:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111Ab3I2Erb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 00:47:31 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:35820 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab3I2Era (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 00:47:30 -0400
Received: by mail-la0-f48.google.com with SMTP id er20so3373787lab.35
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 21:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IS3aUpQqjF+1H+vZYAazbRPiIe2NqQ48r02edSffEzU=;
        b=AXiSE3716bSQIXDGBhqu0lfnO1JQP8C0YIdHnAIBe6dTOUy3VAtCl7Uq6ujx07yM+x
         WitHqp0tlUde+lXRhuWEVpWpJmK0KU9x5JFdky0iV1EUTuDrtQH8Kt+gXkS/c9Cw9FiT
         oWZvBpZ5p1J1jDfA0vawjg37uscIC2UJzsYr8eXO42dUvFtr257+LgASndptRKHKBj0O
         PX8D+xFwSQvuS/N6tNmRmGlRTtBEEGZRZuszTC/b/hnkhDzXkZ+r7spBD0PJ7R5OUcZ3
         0uiv1FEpWa1087SsxrpnRO6OUotBKda7vbE8QUsTGLHaAW9tji3W3MdivZn/39UhcNBM
         drag==
X-Received: by 10.112.155.39 with SMTP id vt7mr513273lbb.29.1380430048416;
 Sat, 28 Sep 2013 21:47:28 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Sat, 28 Sep 2013 21:47:28 -0700 (PDT)
In-Reply-To: <CALkWK0m+LW-R-WJ6DmQkf1GKbCgvpzaGc2=rCNnmiPkf8x_qLg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235584>

On Sat, Sep 28, 2013 at 11:30 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> +test_expect_success 'argument passing' '
>> +       cat > script <<-"EOF" &&
>> +       p($0)
>> +       p(ARGV)
>> +       EOF
>> +       git ruby script foo bar > actual &&
>> +       cat > expected <<-EOF &&
>> +       "script"
>> +       ["foo", "bar"]
>> +       EOF
>> +       test_cmp expected actual
>> +'
>
> So, git-ruby is a new builtin that's just like a ruby interpreter,
> except that it has certain git-related functions defined: you pass it
> source code on stdin, and it returns the result on stdout. I wonder
> what the purpose of passing arguments to it is though.

git ruby is just like ruby, so you can pass the script from stdin, or
you can specify the script name.

>> +test_expect_success 'test for_each_ref()' '
>> +       test_commit foo &&
>> +       git ruby > actual <<-EOF &&
>> +       for_each_ref() do |name, sha1, flags|
>> +               puts "%s: %s" % [name, sha1_to_hex(sha1)]
>> +       end
>> +       EOF
>> +       git for-each-ref --format="%(refname): %(objectname)" > expected &&
>> +       test_cmp expected actual
>> +'
>
> I find it interesting that you chose to implement for-each-ref in the
> initial version. It currently takes no arguments, but we can always
> extend it to do ref-hierarchy filtering like f-e-r in the future.

It takes no arguments because for_each_ref()(refs.h) takes no
arguments (that Ruby would need). builtin/for-each-ref.c uses
for_each_rawref()(refs.h), which is basically the same.

-- 
Felipe Contreras
