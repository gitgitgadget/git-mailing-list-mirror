From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Wed, 3 Jun 2009 11:21:37 +0200
Message-ID: <200906031121.38616.jnareb@gmail.com>
References: <200905122329.15379.jnareb@gmail.com> <200906030250.01413.jnareb@gmail.com> <20090603012940.GA3355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jun 03 11:22:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBmfi-0000Bh-C1
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 11:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbZFCJVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 05:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbZFCJVs
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 05:21:48 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:61320 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbZFCJVr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 05:21:47 -0400
Received: by fxm12 with SMTP id 12so7234087fxm.37
        for <git@vger.kernel.org>; Wed, 03 Jun 2009 02:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=joQGICnpWszRkKqNQxHBE2N1Z1amuWFnJjxjA/AXuoc=;
        b=fKTnVGgolduLVRzKqmYLyC3HyGjb3WqbRNUYWRfzXnBV09b55tnnky7lFPfSBow67P
         JiQCX9jC+hqYCufL4TLXlr3bkSIZ7WsM6YewwwT1T1XGdxmyG0qLqvKEt4kU3iMPkasr
         /qeGVYHZ9GDUD5NIZFFkcH311pw3xefy9JzPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=f5fGnyq3vRR+Ge1ycDkIL7rcaQsW+cGy8vzOk9A34gYGlBMMoXaLuyzIfMUz4gu+QA
         1YcJWSI5ruODQUffi17qZsQywrZwjsv/+SI8qPkXgr9fHhHVE+ody9TinUjGLtOvrIx8
         J9uDtSEsFIbvx0qtJPUoR7EMibqWClH88b55A=
Received: by 10.86.1.1 with SMTP id 1mr933529fga.0.1244020907587;
        Wed, 03 Jun 2009 02:21:47 -0700 (PDT)
Received: from ?192.168.1.13? (abws210.neoplus.adsl.tpnet.pl [83.8.242.210])
        by mx.google.com with ESMTPS id 4sm16197007fgg.28.2009.06.03.02.21.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Jun 2009 02:21:46 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090603012940.GA3355@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120593>

On Wed, 3 Jun 2009, Shawn O. Pearce wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
>> On Wed, 3 Jun 2009, Shawn O. Pearce wrote:
>>>>>
>>>>> The client connects and sends the request header. The clone command
>>>>>
>>>>> 	$ git clone git://myserver.com/project.git
>>>>>
>>>>> produces the following request:
>>>>>
>>>>> 	0032git-upload-pack /project.git\\000host=myserver.com\\000
>> [...]
>> 
>> So this mean that when cloning via SSH 
>> 
>>   $ git clone ssh://myserver.com/project.git
>> 
>> instead of this first request git would simply invoke [something like]:
>> 
>>   # ssh myserver.com git-upload-pack project.git
> 
> Actually, 
> 
>     # ssh myserver.com git-upload-pack /project.git
>  
>> isn't it? (I am not sure if it uses "project.git" or "/project.git", 
>> and how it does generate full pathname for repository).
> 
> In an ssh:// format URI, its absolute in the URI, so the / after
> the host name (or port number) is sent as an argument, which is then
> read by the remote git-upload-pack exactly as is, so its effectively
> an absolute path in the remote filesystem.
> 
> In a "user@host:path" format URI, its relative to the user's home
> directory, because we run:
> 
>     # ssh user@host git-upload-pack path

By the way, this accidentally shows why one might want to prefer 
scp-like / ssh-like "URL" for SSH fetch / push, i.e.

  [user@]myserver.com:/path/to/repo.git/

rather than ssh:// URL version

  ssh://[user@]myserver.com/path/to/repo.git/

On the other hand I think only URL version allows to specify
nonstandard port (well, that and ~/.ssh/config).

>> BTW I wonder why we use stuffing here using "\0" / NUL as separator
>> trick, and whether line has to be terminated with "\0", or can it be
>> terminated with "\n".
> 
> Stuffing here?  What are we talking about again?

I'm sorry, I was too cryptic here.

I meant that in the request line for fetching via git:// protocol

	0032git-upload-pack /project.git\\000host=myserver.com\\000

you separate path to repository from extra options using "\0" / NUL
as a separator. Well, this is only sane separator, as it is path 
terminator, the only character which cannot appear in pathname 
(although I do wonder whether project names with e.g. control 
characters or UTF-8 characters would work correctly).

Is the final terminating character required to be NUL ("\0"), or can
it be for LF ("\n"), i.e.

	0032git-upload-pack /project.git\\000host=myserver.com\\n

What options besides (required?) "host=<server>[:<port>]" are supported?
Do I understand correctly that "host=<host>" information is required
for core.gitProxy to work, isn't it?

>>>>  * no-progress
>> 
>> What that does mean?
> 
> The client was started with "git clone -q" or something, and doesn't
> want that side brand 2.  Basically the client just says "I do not
> wish to receive stream 2 on sideband, so do not send it to me,
> and if you did, I will drop it on the floor anyway".

Does this mean that if server does not support "no-progress" capability
then client is required to drop diagnostic by itself? Can client request
to not use sideband (multiplexing) if it is asking for "no-progress";
or is multiplexing required for possible signaling of error condition 
on channel 3?
  
>> It is a bit pity that git protocol was not created with extendability
>> (like capabilities) in mind...
> 
> Yes, no doubt.  There are many things I would have done differently,
> given that I now have 20/20 hindsight vision into the past's future.
> 
> :-)
> 
> The protocol (mostly) works fine as-is.  Its widely distributed in
> terms of clients using it on a daily basis.  Its likely to continue
> to serve our needs well into the future.  So, it is what it is.

I do wonder if existing Internet Standard (in the meaning of RFC) 
protocols also have such kludges and hacks...

>> By the way, how client does know that server started to send final
>> data, i.e. packfile multiplexed / interleaved with progress reports,
>> and should expect <pkt-line-band> rather than <pkt-line> output?
> 
> After the client receives a "ACK" or "NAK" for the number of
> outstanding flushes it still has, *after* it has sent "done".
> This also varies based on whether or not multi_ack was enabled.
> 
> Its ugly.  But basically you keep a running counter of each "flush"
> sent, and then you send a "done" out, and then you wait until
> you have the right number of ACK/NAK answers back, and then the
> stream changes format.

Hmmm... perhaps it would be better if pkt-line-sideband had some
distinguishing characteristics from ordinary pkt-line, or that sending
multiplexed (with sideband) output was preceded by some signal like
"0001" or "0004" or "0005\n", or "000dsideband\n".  But as you said
hindsight is 20/20.


P.S. By the way, is pkt-line format original invention, or was it 
'borrowed' from some other standard or protocol?

-- 
Jakub Narebski
Poland
