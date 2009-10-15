From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: My custom cccmd
Date: Fri, 16 Oct 2009 00:37:36 +0300
Message-ID: <94a0d4530910151437s780bd96anca82d2b26ef99e0a@mail.gmail.com>
References: <94a0d4530910150620g733bdf0aq88660053f869b0a9@mail.gmail.com>
	 <7vk4yw4dy3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 23:43:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyY6R-0000o0-JZ
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 23:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933492AbZJOVjZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Oct 2009 17:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755727AbZJOVjZ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 17:39:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:47511 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790AbZJOVjY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Oct 2009 17:39:24 -0400
Received: by fg-out-1718.google.com with SMTP id d23so2168110fga.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2009 14:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7M+9Ny5G4lfnFRI4qsppA0/OV8etuT21FkxGBL5JPK8=;
        b=uswSfdyopjAMjF0Acmi43StoNG3YLxTBu88+A7f27n4QDVOK5uRavriHYc3iBMdgK0
         qdJ+24p1sTXk+hn6s2iFYPpP8IKLDJebyQqXo7b9RN/2LJKanEQmYcwTeqgMluUwFN+0
         +FZocTDxnObwKVV6TPD3yXMyfntt6DmRBudtM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DeMWom0XM3VzYYxlsDK9yr7935QQ9dwbQcUTbjPPZvhXNknSAo4AKCT/WB6mwW3onF
         1RdFrn7QeAzFrEligtZHFdOamp+9v24BpFe3XXhboWuCYSF0le8RJqXoZTWu+/a1PTGV
         ufTmSHmzmGEH5TClMtzFx5ZcYaZHA80CmYBWc=
Received: by 10.86.227.26 with SMTP id z26mr661809fgg.76.1255642656465; Thu, 
	15 Oct 2009 14:37:36 -0700 (PDT)
In-Reply-To: <7vk4yw4dy3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130424>

On Thu, Oct 15, 2009 at 11:09 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Hi,
>>
>> I love the new option to run a cccmd and how good it works on the
>> linux kernel, but I couldn't find a generic script. So I decided to
>> write my own.
>>
>> It's very simple, it just looks into the authors of the commits that
>> modified the lines being overridden (git blame). It's not checking f=
or
>> s-o-b, or anything fancy.
>>

<snip/>

> Comments.
>
> =C2=A0#0. Gaahhh, my eyes, my eyes!! =C2=A0Can't you do this ugly run=
 of infinite
> =C2=A0 =C2=A0 number of "end"s?

Hehe, sure. Will do.

> =C2=A0#1. You are not making sure that you start blaming from the com=
mit the
> =C2=A0 =C2=A0 patch is based on, so your -La,b line numbers can be of=
f. =C2=A0If you can
> =C2=A0 =C2=A0 assume that you are always reading format-patch output,=
 you can learn
> =C2=A0 =C2=A0 which commit to start from by reading the first "magic"=
 line.

The 'From' magic line points to the actual commit the patch was
generated from, so it would actually be @from^.

This of course would only work if the patches have the corresponding
commits in the current tree (which is the case most of the time).

And makes sense only for the first patch, the rest of the patches
would use a wrong commit as a base. See below.

> =C2=A0#2. If you have two patch series that updates one file twice, s=
ome
> =C2=A0 =C2=A0 changes in your second patch could even be an update to=
 the changes
> =C2=A0 =C2=A0 you introduced in your first patch. =C2=A0After you fix=
 issue #1, you
> =C2=A0 =C2=A0 would probably want to fix this by excluding the commit=
s you have
> =C2=A0 =C2=A0 already sent the blames for.

How exactly? By looking at the commit from 'git blame' and discarding
it? That would be a bit tricky since each instance of 'cccmd' is not
aware of the previous ones.

> =C2=A0#3. Does the number of commits you keep per author have any sig=
nificance?
> =C2=A0 =C2=A0 I know it doesn't in the implementation you posted, but=
 should it,
> =C2=A0 =C2=A0 and if so how?

Not currently. Once I add support for s-o-b it might be useful.
Currently I left it in order to order the CC's by the count, but it
turned out to be a bit messier than I thought, and the advantage is
almost nothing.

I'll clean it up.

Taking in consideration the previous comments, here is v2:

#!/usr/bin/env ruby

@authors =3D {}

def parse_blame(line)
  key, value =3D line.split(" ", 2)
  case key
  when "author"
    @name =3D value
  when "author-mail"
    @mail =3D value
    author =3D "\"#{@name}\" #{@mail}"
    @authors[author] =3D true
  end
end

ARGV.each do |filename|
  patch_file =3D File.open(filename)
  patch_file.each_line do |patch_line|
    case patch_line
    when /^---\s+(\S+)/
      @source =3D $1[2..-1]
    when /^@@\s-(\d+),(\d+)/
      blame =3D `git blame -p -L #{$1},+#{$2} #{@source} | grep author`
      blame.each_line { |l| parse_blame(l.chomp) }
    end
  end
end

@authors.each_key do |a|
  puts a
end

--=20
=46elipe Contreras
