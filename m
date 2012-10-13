From: Tomi Belan <tomi.belan@gmail.com>
Subject: [BUG?] git-subtree behavior when the -P tree is removed and recreated
Date: Sat, 13 Oct 2012 15:47:08 +0200
Message-ID: <CACUV5ofmuUku=byR1_+Cq+g0SdzqZbH1Z1tPfQf4eNABVyYb_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 13 15:47:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TN24F-0005Bg-HF
	for gcvg-git-2@plane.gmane.org; Sat, 13 Oct 2012 15:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210Ab2JMNrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2012 09:47:39 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:53224 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818Ab2JMNrj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 09:47:39 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so3707613oag.19
        for <git@vger.kernel.org>; Sat, 13 Oct 2012 06:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=j7p/o2W80iJTPycL/ChiFeGUMQiRNTBP9yZAHy5qPpU=;
        b=YuSPptBfaP+RjEMVxvEcjPjMYC7LknjMXrDKhdprqTDhnzBHd5e5GeTERSaugp2DEf
         OtPAlv0KYBnzveTQ1ebe5x7/S03BYJ72qJXelkCgPlv3By6/U6mJgC6Qv2kOcL3MzgdQ
         eW1Q1IkKC1YzqAcMyNsx9v4Ndto6VCm1YFZcuS38WrdOiI45ygmKJPh3xdwxIiECh2yf
         Obr3sCAhxoVkrbXOr4PyWzf1cZ0Fq7lDG5OpM4ZFV2oyweHjLXSs9HRYj5VQXlKAa4FR
         qv3wKJhBj1/n+RS3Tz5+HaVqXuy29moOGxT+8YsLNrQG5H1Ht+AGFV2Ojy9s2zIzW964
         LgmQ==
Received: by 10.182.177.99 with SMTP id cp3mr5616631obc.92.1350136058474; Sat,
 13 Oct 2012 06:47:38 -0700 (PDT)
Received: by 10.76.173.198 with HTTP; Sat, 13 Oct 2012 06:47:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207572>

Hello folks,

I think I might've found a bug in git-subtree: I have a repository
containing a directory "foo". I'd like to use its code in other
projects, so I want to split it off into its own repository with
git-subtree. But it doesn't work as it should. I found out that long
ago, my repository contained an unrelated directory also called "foo"
which has since been deleted.

Steps to reproduce (after installing git-subtree from contrib):
git init repo
cd repo
mkdir foo; touch foo/v1
git add -A .; git commit -m v1
rm -rf foo; touch v2
git add -A .; git commit -m v2
mkdir foo; touch foo/v3
git add -A .; git commit -m v3
git subtree split -P foo -b splitfoo --annotate="split "

What should happen: Either (A) splitfoo only contains "split v3", or
(B) splitfoo contains "split v1" and "split v3"

What happens instead: The parent of "split v3" is "v2", so splitfoo's
full history is: "v1" -> "v2" -> "split v3".

Git version: 1.7.12.2

Bonus questions:
- which is the intended behavior, (A) or (B)?
- if it's (B), how do I convince git-subtree to do (A) once this bug
gets fixed? (I might be getting too far ahead of myself here...)

Tomi
