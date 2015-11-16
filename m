From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/2] sendemail: teach git-send-email to list aliases
Date: Mon, 16 Nov 2015 18:50:55 -0500
Message-ID: <CAPig+cSMW2UmTzuyvBFpcpr4tF1FRdxHUPH4+wS3vrZSP9AzJA@mail.gmail.com>
References: <1447618940-27446-1-git-send-email-jacob.e.keller@intel.com>
	<CAPig+cQ929oAZqQM+X68x3PVQ-opwdi3VzjcQTUsaCfVK3411g@mail.gmail.com>
	<1447717227.23262.10.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"spearce@spearce.org" <spearce@spearce.org>,
	"felipe.contreras@gmail.com" <felipe.contreras@gmail.com>,
	"szeder@ira.uka.de" <szeder@ira.uka.de>,
	"jacob.keller@gmail.com" <jacob.keller@gmail.com>,
	"lee.marlow@gmail.com" <lee.marlow@gmail.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 00:51:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyTY6-0005ro-1K
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 00:51:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbbKPXu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 18:50:57 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36369 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbbKPXu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 18:50:56 -0500
Received: by vkha189 with SMTP id a189so190966vkh.3
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 15:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Qp8No8Vxfglk50uOQmFJBWGrfTh+FErk5Ypxtjut3js=;
        b=w7n0BZEW5/znT3uWZwtfa1UtI19MaDpbD1wSCLWmPbLaazyPi3cKeAgcNzD2IAWYPr
         a/8qo8zd6wbvBQXHK2czKJqPIhNa16gDvfjKLK8CwDJIvKOiJ5I6PLrWo/cM+jCHev9Z
         yK0tWtF+ETB+Ptx7Hk8dTAXI5b7aZIHJwJ3FcpD4lL2f8uSP1YaS4ZhMY2qU74abQMNC
         eE9gu35QUVic9mg4aSYVVTquL+I1aqUF213N65Ow77pucT9exnV+xfQDEAJTk16VNwrW
         7mEmVIxqw02Vi82oBi7QF7vDneW9vehCua3hlt2v4qHRXERIbgdAKbveQjMjTJOm1DI7
         G/TQ==
X-Received: by 10.31.174.213 with SMTP id x204mr630088vke.115.1447717856055;
 Mon, 16 Nov 2015 15:50:56 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Mon, 16 Nov 2015 15:50:55 -0800 (PST)
In-Reply-To: <1447717227.23262.10.camel@intel.com>
X-Google-Sender-Auth: 8S3odU34DK0iyAQ9Fbehi1Mludg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281368>

On Mon, Nov 16, 2015 at 6:40 PM, Keller, Jacob E
<jacob.e.keller@intel.com> wrote:
> On Mon, 2015-11-16 at 18:30 -0500, Eric Sunshine wrote:
>> Also, is it possible that some consumer down the road might want
>> richer output which includes the expansion of each alias? For
>> instance, it could emit the alias name as the first token on each
>> line
>> and the expansion as the remainder. Consumers interested in only the
>> alias name would grab the first token on the line and ignore
>> everything else.
>
> Maybe? The problem with printing the full address is that it may not be
> quoted or similar, and it makes the bash completion require an extra
> parameter.. I am not sure how valuable the alias expansion would be for
> use? The main concern I have is we'd need to use another process on top
> to extract only alias names.

It should be possible to extract the alias within the shell itself
without a separate process. For instance:

    read alias rest

will leave the first token in $alias and the remainder of the line in
$rest, and it's all done within the shell process.

>> New test(s) seem to be missing.
>
> I had removed the tests from the old version because they weren't
> necessary anymore. New ones wouldn't hurt here either, though.. I'll
> work on that.

I'm not sure which tests you mean, but I was referring to tests to
make sure that git-send-email recognizes --list-aliases (or
--dump-aliases if you switch to that) and that it produces the
expected output in the expected format.

Also, shouldn't --list-aliases (or --dump-aliases) be mutually
exclusive with many of the other options? New tests would check such
exclusivity as well.
