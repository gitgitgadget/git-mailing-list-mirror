From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: gravatar support
Date: Fri, 19 Jun 2009 16:57:23 +0200
Message-ID: <cb7bb73a0906190757o4d083735t1a3f37396af76c2f@mail.gmail.com>
References: <1245405495-7712-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906191325.00248.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 16:57:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHfX6-0003HW-T8
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 16:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbZFSO5X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2009 10:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbZFSO5X
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 10:57:23 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:63424 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbZFSO5W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jun 2009 10:57:22 -0400
Received: by bwz9 with SMTP id 9so1804705bwz.37
        for <git@vger.kernel.org>; Fri, 19 Jun 2009 07:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5W4N2zMet0wD51/W/xtuNCQh8Z9j/8qFcPl++VCsKkM=;
        b=dKXb/7ujl7g7G6gLadFNcGLneS5poatYc648KV1/d0OsuTTJ8+ISArbtcALmX6/oLJ
         1RyhEMzsaJk/KUAhpVFIpbhyVzUJa1o0YKSR6Q6EExClu3xF6CKVBpDc2u2nyoS9h1bP
         CnnbbBh1rIpgZ0NyTJnBFyrqASrG7hoCUsW1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=W5Tv3bh/+/0yYLS1PI7VDwvWvdAezQadcUVPhkGmYy2ZXYQf/G8T7yiBo3Hu42QVTB
         mwaFoh0A0EvkYTcnXDKbrKJPG3EpUqIZumPwqZkhAVUdt9NBLelnKCjz6ikHJG4ejr78
         kDVa6rWLrJmpX+MmOM3EUXcpMp0UfA1PwYhzw=
Received: by 10.204.102.15 with SMTP id e15mr2617404bko.196.1245423443646; 
	Fri, 19 Jun 2009 07:57:23 -0700 (PDT)
In-Reply-To: <200906191325.00248.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121901>

Hello,

thanks for the comments, I'll send a new patch taking them into
consideration soon.

A few additional replies:

>> + =A0 =A0 # Gravatar support. When this feature is enabled, views su=
ch as
>> + =A0 =A0 # shortlog or commit will display the gravatar associated =
with
>> + =A0 =A0 # the email of the committer(s) and/or author(s). Please n=
ote that
>> + =A0 =A0 # the feature depends on Digest::MD5.
>> +
>> + =A0 =A0 # To enable system wide have in $GITWEB_CONFIG
>> + =A0 =A0 # $feature{'gravatar'}{'default'} =3D [1];
>> + =A0 =A0 # Project specific override is not supported.
>> + =A0 =A0 'gravatar' =3D> {
>> + =A0 =A0 =A0 =A0 =A0 =A0 'override' =3D> 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 'default' =3D> [0]},
>
> Yet another global feature without project specific override. =A0Hmmm=
=2E..
> I wonder if project specific and global (non-overridable) features
> should be separated. =A0But it is question for a separate commit.
>
> Question: why it is not overridable (why project specific override
> is not supported for this feature)? =A0Some projects may use Gravatar=
s,
> some might not, although I guess that usually it is deployment specif=
ic
> feature.

I see it as a deployment feature, and considering that it adds an
(admittedly small) extra load on the server, I thought it was sensible
to make it non-overridable. OTOH, since the load is small, it might be
possible to make it per-project without big issues.

> You would probably want to protect against $size being undefined:
>
> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 $size =3D 32 if (!defined($size) || $siz=
e <=3D 0);
>
> Because currently when you are not passing size parameter to use
> default size you would get the following warning:
>
> =A0Use of uninitialized value in numeric le (<=3D) ...

Oh right.

> Did you run the t9500, adding test enabling gravatars?

Ehrm, no 8-P

> Hmmm... perhaps we should add test with all possible features turned
> on (unless they need extra configuration... oh, so it isn't as easy
> as I initially thought to add this...).

If gravatars can be added easily, I can try doing it.

>> + =A0 =A0 print "<tr><td>author</td><td>" . esc_html($co{'author'}) =
=2E "</td>".
>> + =A0 =A0 =A0 =A0 =A0 "<td rowspan=3D\"2\">" .git_get_gravatar(lc $c=
o{'author_email'}) . "</td></tr>\n" .
>
>> + =A0 =A0 print "<tr><td>committer</td><td>" . esc_html($co{'committ=
er'}) . "</td>".
>> + =A0 =A0 =A0 =A0 =A0 "<td rowspan=3D\"2\">" .git_get_gravatar(lc $c=
o{'committer_email'}) . "</td></tr>\n";
>
> Hmmm... why use 'lc' here and not in other places?

That's a good question. I'm actually not sure if the gravatar service
is case sensitive or not ... the reference implementation uses lc. I
should probably move the lowercasing to git_get_gravar itself.

> Also gravatars are
> not shown in 'history' view, but I guess that could wait for proper
> refactoring of all log-like views/actions to use common infrastructur=
e.

That's part of the reason, the other being that I couldn't find a
satisfactory way to do it 8-P

> Those all look nice with the *default* font sizes. =A0But as the size=
 of
> gravatar is used when constructing gravatar URL, to pass to gravatar.=
com
> I don't see how this problem can be resolved... =A0Beside making it
> configurable, I guess...

That's something I hadn't thought about, honestly. The problem of
course is that the font sizes get customized via CSS, but the gravatar
size would get customized at the cgi level ... so unless we parse the
CSS from the cgi it cannot be done automatically.

--=20
Giuseppe "Oblomov" Bilotta
