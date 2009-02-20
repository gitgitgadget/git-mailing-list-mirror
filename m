From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2 1/2] git-gui: handle non-standard worktree locations
Date: Fri, 20 Feb 2009 02:20:55 +0100
Message-ID: <cb7bb73a0902191720w1c49e56fsa44309373802602b@mail.gmail.com>
References: <1235006145-16760-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1235006145-16760-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <alpine.DEB.1.00.0902190307390.10279@pacific.mpi-cbg.de>
	 <cb7bb73a0902191621x4e7a66bcj427095906e5a4078@mail.gmail.com>
	 <alpine.DEB.1.00.0902200137390.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 20 02:22:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaK61-000497-6Z
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 02:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754236AbZBTBU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 20:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754114AbZBTBU6
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 20:20:58 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:50989 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182AbZBTBU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 20:20:57 -0500
Received: by ewy14 with SMTP id 14so650218ewy.13
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 17:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zMnaaGxdmafgx2yfaQdTnhL4RGtJ9bdaRuAr76Xdn+0=;
        b=FQaudcsXVHKD0VEuO4LP33MFhTn/tdOZUu7ynHrkivim/hpdIsh6bcOOftVdZI0L7d
         1UHd99bGZXh+5w8c7rpRe0gPcOWPpZjSoUheH2C/9LjRDJ9qiCdRT2XlYysMZoVwg12C
         9o9SCWWPaJk3Va7NktvvoaLru5cG0phGZTlMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=I71dzD51vDiFQsKbRjGb7jPuOw5t9l7MAXY/0y16iFV07Lr383n1mZviMSSj71//YA
         QVX4mWNpBf0tgGxuITxGtETiYxst9A2ggW44hVmDV7KUpg6Sw+/goNXIgn+J0f3X76j4
         hT3jPgkBSqte6ktIjfa9N8h8Xfx37aGEePPjQ=
Received: by 10.210.51.18 with SMTP id y18mr162701eby.103.1235092856001; Thu, 
	19 Feb 2009 17:20:56 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902200137390.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110778>

On Fri, Feb 20, 2009 at 1:44 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 20 Feb 2009, Giuseppe Bilotta wrote:
>
>> Since there is NO practical reason NOT to support these unusual
>> configurations, and since the changes do NOT break standard usage, your
>> personal dislike for abnormal worktree configurations is scarcely a
>> meaning obstacle to patch inclusion.
>
> It is not a personal dislike.  It is based on experience.

My experience is that tools that don't support nonstandard worktree
configurations are either very old or plain broken, and in both cases
they can and should be updated/fixed to cope with such configurations.

>> (And please excuse the attitude, but yours is absolutely the worst
>> I've ever seen on this mailing list, and yes it has been abundantly
>> discussed.(
>
> And what exactly did you want to achieve with that comment?

Nothing, but I still felt there was a need to clarify that this it not
my typical attitude.

>> >> +# _gitdir exists, so try loading the config
>> >> +load_config 0
>> >> +apply_config
>> >> +# try to set work tree from environment, falling back to core.worktree
>> >> +if {[catch { set _gitworktree $env(GIT_WORK_TREE) }]} {
>> >> +     set _gitworktree [get_config core.worktree]
>> >> +}
>> >>  if {$_prefix ne {}} {
>> >> -     regsub -all {[^/]+/} $_prefix ../ cdup
>> >> +     if {$_gitworktree eq {}} {
>> >> +             regsub -all {[^/]+/} $_prefix ../ cdup
>> >> +     } else {
>> >> +             set cdup $_gitworktree
>> >> +     }
>> >
>> > It appears as if you redo a the logic laid out in setup.c.  Don't.
>> > Instead, teach rev-parse to output the path of the work tree.
>> >
>> > Oh, wait, --show-cdup already shows that...
>>
>> As spearce itself remarked while reviewing the first round of this
>> patchset, git-gui is currently backwards compatible as far as git
>> 1.5.0. Introducing new features in future versions of git rev-parse is
>> not going to help here anyway. (Also, I have no idea if this
>> --show-cdup worked in 1.5.0 or not, I just took the existing code and
>> adapted it to the possibility of gitworktree being already defined.)
>
> Well, I actually looked.  Not really far, just 1.4.0.  It has --show-cdup.
> It does not have worktree.

git blame puts it in 1.0.3, actually. Regardless, changes such as
replacing the $prefix regexp with a show-cdup was not in the scope of
this patch. More to the point, given the definition of $_prefix, the
additional cost of the extra git-rev-parse call that would do exactly
the same thing that we do now is totally not worth it.

>> >> @@ -1076,11 +1089,15 @@ if {$_prefix ne {}} {
>> >>               error_popup [strcat [mc "Cannot use funny .git directory:"] "\n\n$_gitdir"]
>> >>               exit 1
>> >>       }
>> >> -     if {[catch {cd [file dirname $_gitdir]} err]} {
>> >> +     if {$_gitworktree eq {}} {
>> >> +             set _gitworktree [file dirname $_gitdir]
>> >> +     }
>> >
>> > This is certainly wrong in bare repositories.
>>
>> It's also totally irrelevant and not less wrong than what the previous
>> code did, since it used [file dirname $_gitdir] all across the code to
>> do what I do with $_gitworktree now.
>>
>> So the current code is correct in all the ways the old code was, plus
>> in quite a few more ways where the previous code was wrong. And
>> although there might be a couple of cases that the new approach
>> doesn't fix, I'd rather prefer you pointed out which cases they where,
>> how could they fail, and what possible ways you can suggest to work
>> around them.
>
> It would not take all that much effort to address my comment in terms
> of code.

Except for the fact that there was nothing to address.

-- 
Giuseppe "Oblomov" Bilotta
