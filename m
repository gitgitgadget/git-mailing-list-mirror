From: "Jeffrey S. Haemer" <jeffrey.haemer@gmail.com>
Subject: git commit/push can fail silently when clone omits ".git"
Date: Sun, 4 Nov 2012 12:50:58 -0700
Message-ID: <CAABvdFyn=_2JKHYA_jAduoNAti3U0YFHbdU94esm=m8R0s2LcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d0401730555245304cdb0b1e8
To: Git Issues <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 20:52:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TV6F6-00078l-Sc
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 20:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027Ab2KDTvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 14:51:22 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46903 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab2KDTvW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2012 14:51:22 -0500
Received: by mail-lb0-f174.google.com with SMTP id n3so3756743lbo.19
        for <git@vger.kernel.org>; Sun, 04 Nov 2012 11:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=pWYutLbKULd6w/HJclcpTQyHAIld9hoKfHZEIoGgD/g=;
        b=WlziIPDgOAa5T4ZdpmwvsucR2useM5oCi9JwIqnIj5lnw0uPYrcOphvThlzrpYH+k5
         wftgt3VwS9/j1iuYZs5OyxMou5MJKXd7kBPeOUfkCPjPRzQVFEIgV9/oLOI1+5W5IW6Q
         jOQfi6tlPjf7VNBNHW/QrtUk0lOFZhKrNIFo8JV2ljwpNWiC/ZLD52iXzceGkSkC+jRR
         XJzIcIt+HTBwI5XzWD7mump+fz+tR/xiDK9EHj338nCis19kXuXzcvyAoDfZNglUYC22
         ZUXvXtP9GyfkSe/rzc+MnzQv1NAzcffN3RWqGEwHa15QzG29JSB7qzm898BtnY8LnAfV
         Amwg==
Received: by 10.112.102.230 with SMTP id fr6mr3143550lbb.112.1352058679927;
 Sun, 04 Nov 2012 11:51:19 -0800 (PST)
Received: by 10.112.150.106 with HTTP; Sun, 4 Nov 2012 11:50:58 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209038>

--f46d0401730555245304cdb0b1e8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Ladies and Gentlemen,

I'm running git 1.7.9.5 on Ubuntu 12.04.1 LTS

I got bitten by what follows. Yes, it's an edge case. Yes I now understand
why it does what it does. Yes the right answer is "Don't do that, Jeff." :-=
)

Still, it took me a little time to figure out what I'd done wrong because
the failure is silent, so I thought I'd document it. Perhaps there's even
some way to issue an error message for cases like this.

The attached test script shows the issue in detail, but here's the basic
failure:

$ ls
hello.git
$ git clone hello # *Mistake!* Succeeds, but should have cloned "hello.git"
or into something else.
$ cd hello; touch foo; git add foo; git commit -am"add a new file"
$ git status # says I'm a rev ahead of the origin
$ git push # nothing pushed
$ git status # says everything's okay

At this point hello/foo still exists, there's nothing to commit, git diff
origin/master reports nothing, yet foo was never pushed to hello.git.

HTH!

--
Jeffrey Haemer <jeffrey.haemer@gmail.com>
720-837-8908 [cell], http://seejeffrun.blogspot.com [blog],
http://www.youtube.com/user/goyishekop [vlog]
=D7=A4=D7=A8=D7=99=D7=99=D7=94=D7=99=D7=99=D7=98? =D7=93=D7=90=D7=A1 =D7=90=
=D7=99=D7=96 =D7=99=D7=90=D6=B7=D7=A0=D7=92 =D7=93=D7=99=D7=A0=D7=A2=D7=9F =
=D7=95=D7=95=D7=90=D6=B8=D7=A8=D7=98.

--f46d0401730555245304cdb0b1e8
Content-Type: application/x-sh; 
	name="clone-from-suffixless-gitrepo-issue.sh"
Content-Disposition: attachment; 
	filename="clone-from-suffixless-gitrepo-issue.sh"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h94kt4jb0

IyEvYmluL2Jhc2ggLWUKIyBJbGx1c3RyYXRlIGFuIGVkZ2UtY2FzZSBmYWlsdXJlIGZvciBjbG9u
ZS9jaGFuZ2UvcHVzaAoKIyBlcnJvciByZXBvcnRzCndhcm4oKSB7CiAgZWNobyAkKiA+JjIKfQoK
ZGllKCkgewogIGVjaG8gJCogPiYyCiAgZXhpdCAtMQp9CgojIG1ha2UgYSBwbGFjZSB0byB3b3Jr
CmNyZWF0ZS1kZW1vLWRpcigpIHsKCiAgIyBmaXJzdCBvZiBhbGwsIGRvIG5vIGhhcm0KICAjIGlm
IHlvdSBvd24gdGhlIHN5c3RlbSwgeW91IG1pZ2h0IHdhbnQgdG8ganVzdCAicm0gLXJmICRkZW1v
IgoKICBbIC1kICRkZW1vIF0gJiYKICAgIGRpZSAiJGRlbW8gYWxyZWFkeSBleGlzdHMuIFJlbW92
ZSBiZWZvcmUgcnVubmluZyIKCiAgbWtkaXIgJGRlbW8KICBjZCAkZGVtbwp9CgojIG1ha2UgYSBi
YXJlIHJlcG8KbWtyZXBvKCkgewogIHJtIC1yZiBoZWxsbyoKICBta2RpciBoZWxsbwogIGNkIGhl
bGxvCiAgdG91Y2ggUkVBRE1FCiAgZ2l0IGluaXQKICBnaXQgYWRkIC4KICBnaXQgY29tbWl0IC1t
ImluaXRpYWwiCiAgY2Qgfi0KICBnaXQgY2xvbmUgLS1iYXJlIGhlbGxvCiAgcm0gLXJmIGhlbGxv
Cn0KCiMgYWRkIGZpbGUgdG8gb3JpZ2luIHJlcG8gZnJvbSBhIGNsb25lCmFkZC10by1mcm9tKCkg
ewogICMgcGVlbCBvZmYgb3B0aW9uYWwgYXJnCiAgY2FzZSAkMSBpbgogICAgLSopIGFyZ3M9JDE7
IHNoaWZ0IDs7CiAgZXNhYwoKICBvcmlnaW5fbmFtZT0kMQogIGNsb25lX25hbWU9JHsyOi1oZWxs
b30KICBta3JlcG8KCiAgIyBpbiBjYXNlIGNsb25lIGlzIHRvIGEgc3ViZGlyZWN0b3J5CiAgaWYg
WyAkKGRpcm5hbWUgJGNsb25lX25hbWUpICE9ICIuIiBdOyB0aGVuCiAgICBta2RpciAtcCAkKGRp
cm5hbWUgJGNsb25lX25hbWUpCiAgZmkKCiAgIyBjbG9uZSBhbmQgYWRkIGEgbmV3IGZpbGUKICBn
aXQgY2xvbmUgJGFyZ3MgJG9yaWdpbl9uYW1lICRjbG9uZV9uYW1lCiAgcHVzaGQgJGNsb25lX25h
bWUKICB0b3VjaCBzZWNvbmQtZmlsZQogIGdpdCBhZGQgLgogIGdpdCBjb21taXQgLWFtImFkZCBh
IHNlY29uZCBmaWxlIgogIGdpdCBzdGF0dXMKCiAgIyBub3cgcHVzaCBhbmQgd2F0Y2ggd2hhdCBo
YXBwZW5zCiAgZ2l0IHB1c2gKICBnaXQgc3RhdHVzCiAgcG9wZAoKICAjIHN0b3JlIGF3YXkgZm9y
ZW5zaWMgZXZpZGVuY2UKICBpZiBbICQoZGlybmFtZSAkY2xvbmVfbmFtZSkgIT0gIi4iIF07IHRo
ZW4KICAgIHJtIC1yZiBPcmlnaW5hbC1jbG9uZQogICAgbXYgJChkaXJuYW1lICRjbG9uZV9uYW1l
KSBPcmlnaW5hbC1jbG9uZQogIGVsc2UKICAgIG12ICRjbG9uZV9uYW1lIE9yaWdpbmFsLWNsb25l
CiAgZmkKCiAgIyBzZWUgaWYgdGhlIGFkZGl0aW9uIHdvcmtlZAogIGdpdCBjbG9uZSBoZWxsby5n
aXQKICBpZiBbIC1mIGhlbGxvL3NlY29uZC1maWxlIF07IHRoZW4KICAgIHdhcm4gIlskRlVOQ05B
TUUgJCpdOiBzdWNjZXNzIgogICAgcm0gLXJmIE9yaWdpbmFsLWNsb25lCiAgZWxzZQogICAgd2Fy
biAiWyRGVU5DTkFNRSAkKl06IHNlY29uZCBjb21taXQgbmV2ZXIgcHVzaGVkIHRvIG9yaWdpbiIK
ICAgIHdhcm4gIkFsbCBldmlkZW5jZSBpcyBpbiAkZGVtbyIKICAgIGVjaG8gIj09PSBIZXJlJ3Mg
dGhlIGxvZyBvZiB0aGUgY2xvbmUgPT09IgogICAgY2QgT3JpZ2luYWwtY2xvbmU7IGdpdCBsb2c7
IGNkIC4uCiAgICBlY2hvCiAgICBlY2hvICI9PT0gSGVyZSdzIHRoZSBsb2cgb2YgdGhlIG9yaWdp
biA9PT0iCiAgICBjZCBoZWxsby5naXQ7IGdpdCBsb2c7IGNkIC4uCiAgICBlY2hvCiAgICBkaWUg
IlskRlVOQ05BTUUgJCpdOiBGQUlMIgogIGZpCn0KCmRlbW89L3RtcC9kZW1vCmNyZWF0ZS1kZW1v
LWRpcgojIHRoaW5ncyB0aGF0IHdvcmsKYWRkLXRvLWZyb20gaGVsbG8uZ2l0IGhlbGxvCmFkZC10
by1mcm9tIGhlbGxvIGhlbGxvMgphZGQtdG8tZnJvbSBoZWxsbyB3b3Jrc3BhY2UvaGVsbG8KCiMg
dGhpbmdzIHRoYXQgZmFpbCBiZWNhdXNlIHRoZSBjbG9uZSBzdWNjZWVkcywKIyBidXQgdGhlIHB1
c2ggZ2V0cyBjb25mdXNlZCBhbmQgZmFpbHMgc2lsZW50bHkKCmFkZC10by1mcm9tIGhlbGxvIGhl
bGxvCiMgb3IKIyAgIGFkZC10by1mcm9tIGhlbGxvCiMgb3IgZXZlbgojICAgYWRkLXRvLWZyb20g
LS1uby1oYXJkbGlua3MgaGVsbG8KCnJtIC1yZiAkZGVtbwkjIGlmIGV2ZXJ5dGhpbmcgc3VjY2Vl
ZHMsIHRoaXMgY2xlYW5zIHVwCgpleGl0IDAK
--f46d0401730555245304cdb0b1e8--
