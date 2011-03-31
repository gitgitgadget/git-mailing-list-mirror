From: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Subject: Re: error: cannot run hooks/pre-receive: No such file or directory
Date: Thu, 31 Mar 2011 09:20:23 +0200
Message-ID: <AANLkTikb42kG8DyZ7KHhin+=1X72XvN9p-mjed0oJsk=@mail.gmail.com>
References: <AANLkTinehsLJWYona7ONqquWpCZozr3hW-JNMhYz4Rvn@mail.gmail.com> <20110330200442.GA30663@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Mar 31 09:20:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5CBW-0007yt-Uf
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 09:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757040Ab1CaHUo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2011 03:20:44 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51801 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756990Ab1CaHUn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 03:20:43 -0400
Received: by iwn34 with SMTP id 34so2094291iwn.19
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 00:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:cc:content-type:content-transfer-encoding;
        bh=q+BObvTjkafw4SaJ4gchgLo9gZQcJZqxOMrWHAjOo88=;
        b=fLhR3vYuqja0thvBVl8cSk8g37dIz+wPlIrWcfjs+CWErBQaQZkCRB6POLaHpw5Qxr
         Dlo/jrB4lVbcnTI0s64p4Vjh2TSiAw64SjG/6w0s8/Yi/mhsfAqhmQZXmubNXRCj9P0I
         d+bjqEHn2p+RPi6h+HxsG3lSecFOU91IIWCfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:cc
         :content-type:content-transfer-encoding;
        b=Ek2Uc83Cbyynsx23qtDBxpXldn3xpCKn6KGEUhV45w3VIEIJ0uqe9zgw1mJZRvbZrP
         YEyofu4tJ2C/E2TPaWZuDW1OR+vECS0dEiA14iaCfWY3bHW71pJKZArgS10ObCwwYXpQ
         A8QMQslmu3Jwgzkb5FSaahWPJSvpbHF1EIJl8=
Received: by 10.43.70.2 with SMTP id ye2mr2775231icb.345.1301556043136; Thu,
 31 Mar 2011 00:20:43 -0700 (PDT)
Received: by 10.42.165.134 with HTTP; Thu, 31 Mar 2011 00:20:23 -0700 (PDT)
In-Reply-To: <20110330200442.GA30663@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170458>

On Wed, Mar 30, 2011 at 10:04 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 30, 2011 at 03:27:14PM +0200, Mathieu Malaterre wrote:
>
>> $ git push
>> Counting objects: 5, done.
>> Delta compression using up to 4 threads.
>> Compressing objects: 100% (3/3), done.
>> Writing objects: 100% (3/3), 304 bytes, done.
>> Total 3 (delta 2), reused 0 (delta 0)
>> error: cannot run hooks/pre-receive: No such file or directory
>> To ssh://malat@gdcm.git.sourceforge.net/gitroot/gdcm/gdcm.old
>> =A0! [remote rejected] master -> master (pre-receive hook declined)
>> error: failed to push some refs to
>> 'ssh://malat@gdcm.git.sourceforge.net/gitroot/gdcm/gdcm.old'
>
> We won't try to execute a hook that doesn't exist, so the "no such fi=
le
> or directory" almost certainly means the #! interpreter is missing.
>
>> I tried with something as simple as :
>>
>> % cat pre-receive
>> #!/usr/bin/ruby
>> % which ruby
>> /usr/bin/ruby
>
> This might be a stupid question, but which machine is that output fro=
m?
> The pre-receive hook runs on the server, so you must have ruby there.=
 I
> ask mainly because I didn't realize sourceforge would give people
> arbitrary shell access on the git boxes.
>
> My next guess would be that the git process runs in some kind of chro=
ot
> that doesn't have ruby in it.

Makes complete sense now. I thought initially that the "no such file"
refered to the actual hooks script. I naively assumed my ssh
connection on sf.net gave me access to the actual git boxes (or maybe
it is executed from a chroot).

In any case rewriting the script in pure shell script (no bash either)
seems to work ok now (*).

However I am now being told that this script should rather go in the
update hooks...


(*)
read rev_old rev_new refname

ref_to_check=3D"refs/heads/master"

if [ "$refname" =3D=3D "$ref_to_check" ]
then
  merge_bases=3D`git merge-base ${rev_old} ${rev_new}`
  if [ "$merge_bases" !=3D "$rev_old" ]
  then
    echo "Non fastward is disallowed"
    exit 1
  fi
  # non-fast-forward case:
  git rev-list --parents $merge_bases..$rev_new \
    | while read x; do
      set -- $x
      if [ "$#" !=3D "2" ]
      then
        echo "Multiple parents: $x";
        exit 1
      fi;
    done
  [ $? -ne 0 ] && exit 1
fi
exit 0
