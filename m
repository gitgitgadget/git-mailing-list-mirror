From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Trouble merging renamed but identical files - CONFLICT (rename/rename)
Date: Sun, 29 Jun 2014 16:26:47 -0400
Message-ID: <CABURp0q1u_Hzz2ni63oHuinFpBTCzZ+=-6h5YpC0k_bQ_03TSA@mail.gmail.com>
References: <CABURp0rFCxxpiQhRYXmN5eBnKhyyOeuFSTj0V1tGZJSNea5iEA@mail.gmail.com>
 <66A60DA77398CD439FA676CEF593977D52477A@exchange.1.internal.pdinc.us>
 <CEAC9BE9F83B4CD0AFD73BBAC8A54232@black> <CABURp0okCDbwLOL3Osj2WtfQ_Qj3v=1FrAV28gJjPy1yzQU7Vg@mail.gmail.com>
 <CABURp0qZVMGMQ8X4P0P1OGF9gNqu__=Uk+Lr7GyBbscm5wL1=w@mail.gmail.com> <35E240FD8DD74A2F9B80FFCBD818A122@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Jason Pyeron <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Sun Jun 29 22:27:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1Lgv-0001Vk-KO
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 22:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbaF2U1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2014 16:27:09 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:45517 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbaF2U1I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2014 16:27:08 -0400
Received: by mail-vc0-f171.google.com with SMTP id id10so6805009vcb.30
        for <git@vger.kernel.org>; Sun, 29 Jun 2014 13:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=w7JDLNeEVxkp2pDkWnojm5KdyOl63YtMMCmAGtO3VlQ=;
        b=vcCZNvCpYFkOmLG0ukLIJo9TDz6Ok/PqMI24TOzNCR3CzlaRa3yBgBkPVURrbCwbNU
         WsPJDL//wBOeSP6hoN4qQ65Dvg3R8TR5GXlRgzZRG0D+dcXqGR0UJE8amvsqiQ8dc5VR
         dlanIw3eGmf88RWRhOWKszJjvXzHGinEjrh77tc7kpN2cWYDA2sisdEIq/ELdQz9LEqS
         JL7yig0doddlnTqa3qvN7OkpF2ds4paRjTVa+Q0vSHQjqXhdY1bfLQJqUENR8N2R5qxT
         gtGPT27prBd7OqUZcsv/f5Owmvh1eVhF1I1l5lKmnplSoEn4kVZg1ZsjnQe4UZTbIKHo
         /amw==
X-Received: by 10.220.203.134 with SMTP id fi6mr23980138vcb.18.1404073627321;
 Sun, 29 Jun 2014 13:27:07 -0700 (PDT)
Received: by 10.58.67.168 with HTTP; Sun, 29 Jun 2014 13:26:47 -0700 (PDT)
In-Reply-To: <35E240FD8DD74A2F9B80FFCBD818A122@black>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252647>

On Sun, Jun 29, 2014 at 4:20 PM, Jason Pyeron <jpyeron@pdinc.us> wrote:
>> -----Original Message-----
>> From: Phil Hord
>> Sent: Sunday, June 29, 2014 16:09
>>
>> On Sun, Jun 29, 2014 at 11:31 AM, Phil Hord
>> <phil.hord@gmail.com> wrote:
>> > On Fri, Jun 27, 2014 at 8:42 PM, Jason Pyeron
>> <jpyeron@pdinc.us> wrote:
>> >> Sorry for the http://pastebin.com/1R68v6jt (changes the merge to
>> >> 1ca13ed2271d60ba93d40bcc8db17ced8545f172, and manually
>> reconciles the merge),
>> >> but it was too long to be readable in the email.
>>
>> Ok, I think I understand the issue you are trying to solve now.
>>
>> Git (rather famously[1]) does not record renames or copies.  It is
>> expected instead that renames and copies will be detected when it is
>> important after the fact. This allows us to ignore rename detection
>> and resolution when creating project history; in the future, better
>> rename/copy detection will "just work" on existing repositories and
>> the repos themselves will not need to be adjusted.
>
> Looking at http://pastebin.com/1R68v6jt , I have a work around.
>
> In summary, 7.git cherry-pick -x HEAD..rebranding , then
>
> git merge $(echo 'Merge of 1ca13ed2271d60ba93d40bcc8db17ced8545f172 branch -
> rebranding' |\
>     git commit-tree -p HEAD -p rebranding \
>          $(git cat-file -p HEAD | grep ^tree | sed -e 's/^tree //') )
>
> Now it is perfect in the blame and log --graph.

Yes, but your workaround unnecessarily duplicates commits and
complicates the history of your project. You are munging your project
to compensate for git's current shortcomings.

But it's your project.  Your choice.
