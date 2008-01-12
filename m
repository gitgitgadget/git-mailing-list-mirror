From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: [ANNOUNCE] GIT 1.5.4-rc3
Date: Sat, 12 Jan 2008 09:26:14 +0200
Organization: Pardus / KDE
Message-ID: <200801120926.14307.ismail@pardus.org.tr>
References: <7vsl13wmas.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 08:25:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDakf-0008ET-5f
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 08:25:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760327AbYALHZO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jan 2008 02:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759805AbYALHZN
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 02:25:13 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:56074 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760243AbYALHY7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jan 2008 02:24:59 -0500
Received: from [192.168.1.3] (unknown [85.97.18.122])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 62EA761F48C8;
	Sat, 12 Jan 2008 09:24:51 +0200 (EET)
User-Agent: KMail/1.9.6 (enterprise 0.20071204.744707)
In-Reply-To: <7vsl13wmas.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70281>

Saturday 12 January 2008 09:11:23 tarihinde Junio C Hamano =C5=9Funlar=C4=
=B1 yazm=C4=B1=C5=9Ft=C4=B1:
> The third rc for the next feature release GIT 1.5.4 is available
> at the usual places:
>
>   http://www.kernel.org/pub/software/scm/git/
>
>   git-1.5.4.rc3.tar.{gz,bz2}			(tarball)
>   git-htmldocs-1.5.4.rc3.tar.{gz,bz2}		(preformatted docs)
>   git-manpages-1.5.4.rc3.tar.{gz,bz2}		(preformatted docs)
>   testing/git-*-1.5.4.rc3-1.$arch.rpm	(RPM)

I am seeing new failures compared to rc2 :

*** t9200-git-cvsexportcommit.sh ***
* FAIL 1: New file
        mkdir A B C D E F &&
             echo hello1 >A/newfile1.txt &&
             echo hello2 >B/newfile2.txt &&
             cp ../test9200a.png C/newfile3.png &&
             cp ../test9200a.png D/newfile4.png &&
             git add A/newfile1.txt &&
             git add B/newfile2.txt &&
             git add C/newfile3.png &&
             git add D/newfile4.png &&
             git commit -a -m "Test: New file" &&
             id=3D$(git rev-list --max-count=3D1 HEAD) &&
             (cd "$CVSWORK" &&
             git cvsexportcommit -c $id &&
             check_entries A "newfile1.txt/1.1/" &&
             check_entries B "newfile2.txt/1.1/" &&
             check_entries C "newfile3.png/1.1/-kb" &&
             check_entries D "newfile4.png/1.1/-kb" &&
             diff A/newfile1.txt ../A/newfile1.txt &&
             diff B/newfile2.txt ../B/newfile2.txt &&
             diff C/newfile3.png ../C/newfile3.png &&
             diff D/newfile4.png ../D/newfile4.png
             )
* FAIL 2: Remove two files, add two and update two
        echo Hello1 >>A/newfile1.txt &&
             rm -f B/newfile2.txt &&
             rm -f C/newfile3.png &&
             echo Hello5  >E/newfile5.txt &&
             cp ../test9200b.png D/newfile4.png &&
             cp ../test9200a.png F/newfile6.png &&
             git add E/newfile5.txt &&
             git add F/newfile6.png &&
             git commit -a -m "Test: Remove, add and update" &&
             id=3D$(git rev-list --max-count=3D1 HEAD) &&
             (cd "$CVSWORK" &&
             git cvsexportcommit -c $id &&
             check_entries A "newfile1.txt/1.2/" &&
             check_entries B "" &&
             check_entries C "" &&
             check_entries D "newfile4.png/1.2/-kb" &&
             check_entries E "newfile5.txt/1.1/" &&
             check_entries F "newfile6.png/1.1/-kb" &&
             diff A/newfile1.txt ../A/newfile1.txt &&
             diff D/newfile4.png ../D/newfile4.png &&
             diff E/newfile5.txt ../E/newfile5.txt &&
             diff F/newfile6.png ../F/newfile6.png
             )

* FAIL 4: Remove only binary files
        git reset --hard HEAD^^ &&
             rm -f D/newfile4.png &&
             git commit -a -m "test: remove only a binary file" &&
             id=3D$(git rev-list --max-count=3D1 HEAD) &&
             (cd "$CVSWORK" &&
             git cvsexportcommit -c $id &&
             check_entries A "newfile1.txt/1.2/" &&
             check_entries B "" &&
             check_entries C "" &&
             check_entries D "" &&
             check_entries E "newfile5.txt/1.1/" &&
             check_entries F "newfile6.png/1.1/-kb" &&
             diff A/newfile1.txt ../A/newfile1.txt &&
             diff E/newfile5.txt ../E/newfile5.txt &&
             diff F/newfile6.png ../F/newfile6.png
             )
* FAIL 5: Remove only a text file
        rm -f A/newfile1.txt &&
             git commit -a -m "test: remove only a binary file" &&
             id=3D$(git rev-list --max-count=3D1 HEAD) &&
             (cd "$CVSWORK" &&
             git cvsexportcommit -c $id &&
             check_entries A "" &&
             check_entries B "" &&
             check_entries C "" &&
             check_entries D "" &&
             check_entries E "newfile5.txt/1.1/" &&
             check_entries F "newfile6.png/1.1/-kb" &&
             diff E/newfile5.txt ../E/newfile5.txt &&
             diff F/newfile6.png ../F/newfile6.png
             )
* FAIL 6: New file with spaces in file name
        mkdir "G g" &&
              echo ok then >"G g/with spaces.txt" &&
              git add "G g/with spaces.txt" && \
              cp ../test9200a.png "G g/with spaces.png" && \
              git add "G g/with spaces.png" &&
              git commit -a -m "With spaces" &&
              id=3D$(git rev-list --max-count=3D1 HEAD) &&
              (cd "$CVSWORK" &&
              git-cvsexportcommit -c $id &&
              check_entries "G g" "with spaces.png/1.1/-kb|with=20
spaces.txt/1.1/"
              )
* FAIL 7: Update file with spaces in file name
        echo Ok then >>"G g/with spaces.txt" &&
              cat ../test9200a.png >>"G g/with spaces.png" && \
              git add "G g/with spaces.png" &&
              git commit -a -m "Update with spaces" &&
              id=3D$(git rev-list --max-count=3D1 HEAD) &&
              (cd "$CVSWORK" &&
              git-cvsexportcommit -c $id
              check_entries "G g" "with spaces.png/1.2/-kb|with=20
spaces.txt/1.2/"
              )
* FAIL 8: File with non-ascii file name
        mkdir -p=20
=C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/=C3=A5/=C3=
=A4/=C3=B6 &&
              echo Foo=20
>=C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/=C3=A5/=
=C3=A4/=C3=B6/g=C3=A5rdets=C3=A5g=C3=A5rdet.txt=20
&&
              git add=20
=C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/=C3=A5/=C3=
=A4/=C3=B6/g=C3=A5rdets=C3=A5g=C3=A5rdet.txt=20
&&
              cp ../test9200a.png=20
=C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/=C3=A5/=C3=
=A4/=C3=B6/g=C3=A5rdets=C3=A5g=C3=A5rdet.png=20
&&
              git add=20
=C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/=C3=A5/=C3=
=A4/=C3=B6/g=C3=A5rdets=C3=A5g=C3=A5rdet.png=20
&&
              git commit -a -m "G=C3=A5r det s=C3=A5 g=C3=A5r det" && \
              id=3D$(git rev-list --max-count=3D1 HEAD) &&
              (cd "$CVSWORK" &&
              git-cvsexportcommit -v -c $id &&
              check_entries \
              "=C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w=
/x/y/z/=C3=A5/=C3=A4/=C3=B6"=20
\
              "g=C3=A5rdets=C3=A5g=C3=A5rdet.png/1.1/-kb|g=C3=A5rdets=C3=
=A5g=C3=A5rdet.txt/1.1/"
              )

[...]
* failed 7 among 10 test(s)

Ideas appreciated.

/ismail

--=20
Never learn by your mistakes, if you do you may never dare to try again=
=2E
