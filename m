From: Misha Penkov <misha.penkov@gmail.com>
Subject: Potential bug: truncated diff output
Date: Thu, 16 Jan 2014 15:19:08 +0900
Message-ID: <CAAyYaWo7wtsVGGxUeE3wwG6UHZ_qc8wcPu4Dk6=DsF8JtyF6_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 16 07:19:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3gIL-0001T6-UQ
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 07:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbaAPGTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 01:19:09 -0500
Received: from mail-oa0-f42.google.com ([209.85.219.42]:63162 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbaAPGTI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 01:19:08 -0500
Received: by mail-oa0-f42.google.com with SMTP id i7so165827oag.29
        for <git@vger.kernel.org>; Wed, 15 Jan 2014 22:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=gPuRPNHg3knp4HiCXycmLh6CcPFjAiEuVRmWdpGipEw=;
        b=dW8Ao6FH3P4ioJntZ936R2XW3DOGabuuRbpj0b4m77r4Y9cFVhgAiIOHggeBT+QEdV
         bV5kyogmxaaKx2I1sjHSV3y60lgv0YSEEBSB5ITmTRZHdNxW30BkHrpDyftPnkogdMtm
         WAcGz6dMpKP8r5utTIEgkL83D4J+ZTt49sOM90Wr5snQDQh/69xDBu1Goh+1N4odOhDR
         umptc8KRhiwvuXHYcedVQdtFl49ttvj+Hiev9KXvldrwbUwV4VfXYFjnBOv4uPpKb2ZJ
         Z/CLb8LD+EycWg7VirJEgA8QH+32jHuRzSXEZhM2ryw7zoefmLYapAH2+Ci+g4Mi+m5B
         p0qA==
X-Received: by 10.60.67.105 with SMTP id m9mr343429oet.58.1389853148275; Wed,
 15 Jan 2014 22:19:08 -0800 (PST)
Received: by 10.60.64.98 with HTTP; Wed, 15 Jan 2014 22:19:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240505>

I have a file in a git repo. It has changed during the last two
commits. I want to see the changes made in these two commits. The
following command should work:

    git diff HEAD^^

but that doesn't get me the expected results. Read on for details.

Last commit: I changed some stuff towards the end of the file, for
example, around line 3145. Here's the full diff (it's here for
reference, don't bother reading all of it):

    $git diff HEAD^ HEAD ieicej.cls
    diff --git a/ieicej.cls b/ieicej.cls
    index ecf8beb..01debd9 100644
    --- a/ieicej.cls
    +++ b/ieicej.cls
    @@ -2250,7 +2250,7 @@
     %
     %\renewcommand{\thesection}{\@arabic\c@section.}
     \renewcommand{\thesection}{\@arabic\c@section}
    -\renewcommand{\thesubsection}{\thesection\,\@arabic\c@subsection}
    +\renewcommand{\thesubsection}{\thesection.\,\@arabic\c@subsection}
     \renewcommand{\thesubsubsection}{%
        \thesubsection.\,\@arabic\c@subsubsection}
     \renewcommand{\theparagraph}{% (
    @@ -2369,7 +2369,7 @@
        \inhibitglue #1%
       \else
        \def\@makefnmark{\kern0pt\hbox to \z@{%
    -    $^{\mbox{\tiny \kern-.5zw （注\@thefnmark{}）\kern-.5zw}}$\hss}}%
    +    $^{\mbox{\tiny \kern-.5zw （\@thefnmark{}）\kern-.5zw}}$\hss}}%
        \kanjiskip\z@ \@plus 1fill \@minus 1fill\xkanjiskip=\kanjiskip
         \jmathkanjiskip=\kanjiskip
        \hbox to 5zw{\inhibitglue #1\hfil}%
    @@ -3145,11 +3145,11 @@
       \kern 2.715\p@}

     \def\@makefnmark{\hbox{$^{\mbox{\tiny \kern-.5zw
    -  （注\kern.1zw\@thefnmark{}）\kern-.5zw}}$}}
    +  （\kern.1zw\@thefnmark{}）\kern-.5zw}}$}}

     \newcommand\@makefntext[1]{\parindent1zw
      \noindent\hbox{\kern-.5zw
    -  （注\kern.1zw\@thefnmark{}）\kern-.5zw\hbox to 1zw{\hss ：\hss}}#1}
    +  （\kern.1zw\@thefnmark{}）\kern-.5zw\hbox to 1zw{\hss ：\hss}}#1}

     \def\thefootnote{\@arabic\c@footnote}
     \def\thempfootnote{\@fnsymbol\c@mpfootnote}


Here's the second-last commit. I changed some things around line 1714.
Full commit diff (again, for reference only):

    $git diff -p HEAD^^ HEAD^ ieicej.cls
    diff --git a/ieicej.cls b/ieicej.cls
    index 1c3b947..ecf8beb 100644
    --- a/ieicej.cls
    +++ b/ieicej.cls
    @@ -1714,51 +1714,57 @@
       \setbox\@tempboxa\vbox{%
         \def\baselinestretch{\@titlepagebaselinestretch}%
         \hskip8mm
    -    \vtop{\footnotesize\baselineskip3mm
    -     \hbox{社団法人\hskip1zw 電子情報通信学会}%
    -     \hbox{THE INSTITUTE OF ELECTRONICS,}%
    -     \hbox{INFORMATION AND COMMUNICATION ENGINEERS}%
    -    }\hfill
    -    \vtop{\footnotesize\baselineskip3mm
    -     \hbox{信学技報}%
    -     \hbox{TECHNICAL REPORT OF IEICE.}%
    -     \hbox{}%
    -    }\hskip8mm\hbox{}\par
    +%    \vtop{\footnotesize\baselineskip3mm
    +%     \hbox{社団法人\hskip1zw 電子情報通信学会}%
    +%     \hbox{THE INSTITUTE OF ELECTRONICS,}%
    +%     \hbox{INFORMATION AND COMMUNICATION ENGINEERS}%
    +%    }\hfill
    +%    \vtop{\footnotesize\baselineskip3mm
    +%     \hbox{信学技報}%
    +%     \hbox{TECHNICAL REPORT OF IEICE.}%
    +%     \hbox{}%
    +%    }\hskip8mm\hbox{}\par
         \vskip\baselineskip
    -    \bgroup
    -     \centering
    -     {\fontsize{16}{23}\selectfont
    -      \@jtitle\par
    -     }%
    -     \vskip.25\baselineskip
    -     \ifx\@jsubtitle\empty
    -     \else
    -      {\huge
    -       \@jsubtitle\par
    -      }%
    -      \vskip.25\baselineskip
    -     \fi
    -     {\LARGE
    -       \@outputJauthorlist\par
    -     }%
    -     \vskip.5\baselineskip
    -     {\fontsize{10.5}{15}\selectfont
    -      \J@affiliate\par
    -      \Jp@affiliate\par
    -      \ifx\@MailAddress\empty
    -       \fmt@Ema
    -       \ifx\header@ma\empty
    -        \vskip.5\baselineskip
    -       \else
    - E-mail: \Mail@ddress\par
    - \vskip.5\baselineskip
    -       \fi
    -      \else
    -       E-mail: \@MailAddress
    -       \vskip.5\baselineskip
    -      \fi
    -     }%
    -    \egroup
    +%
    +% My paper doesn't have a Japanese title.
    +% The template still insists on printing author names and
affiliations in Japanese.
    +% Without a title, it author names and affiliations look kind of stupid.
    +% I think this is the part that does it, so I'm commenting it out
in an effort to reduce the amount of stupid in this paper.
    +%
    +%    \bgroup
    +%     \centering
    +%     {\fontsize{16}{23}\selectfont
    +%      \@jtitle\par
    +%     }%
    +%     \vskip.25\baselineskip
    +%     \ifx\@jsubtitle\empty
    +%     \else
    +%      {\huge
    +%       \@jsubtitle\par
    +%      }%
    +%      \vskip.25\baselineskip
    +%     \fi
    +%     {\LARGE
    +%       \@outputJauthorlist\par
    +%     }%
    +%     \vskip.5\baselineskip
    +%     {\fontsize{10.5}{15}\selectfont
    +%      \J@affiliate\par
    +%      \Jp@affiliate\par
    +%      \ifx\@MailAddress\empty
    +%       \fmt@Ema
    +%       \ifx\header@ma\empty
    +%        \vskip.5\baselineskip
    +%       \else
    +% E-mail: \Mail@ddress\par
    +% \vskip.5\baselineskip
    +%       \fi
    +%      \else
    +%       E-mail: \@MailAddress
    +%       \vskip.5\baselineskip
    +%      \fi
    +%     }%
    +%    \egroup
         \bgroup\large
          \leavevmode
          \unhbox\jabstractbox\par
    @@ -2239,7 +2245,11 @@
     \newcounter{subsubsection}[subsection]
     \newcounter{paragraph}[subsubsection]
     \newcounter{subparagraph}[paragraph]
    -\renewcommand{\thesection}{\@arabic\c@section.}
    +%
    +% Whoever thought it's a great idea to place periods after
section numbers should be shot.
    +%
    +%\renewcommand{\thesection}{\@arabic\c@section.}
    +\renewcommand{\thesection}{\@arabic\c@section}
     \renewcommand{\thesubsection}{\thesection\,\@arabic\c@subsection}
     \renewcommand{\thesubsubsection}{%
        \thesubsection.\,\@arabic\c@subsubsection}
    @@ -2359,7 +2369,7 @@
        \inhibitglue #1%
       \else
        \def\@makefnmark{\kern0pt\hbox to \z@{%
    -    $^{\mbox{\tiny \kern-.5zw （\@thefnmark{}）\kern-.5zw}}$\hss}}%
    +    $^{\mbox{\tiny \kern-.5zw （注\@thefnmark{}）\kern-.5zw}}$\hss}}%
        \kanjiskip\z@ \@plus 1fill \@minus 1fill\xkanjiskip=\kanjiskip
         \jmathkanjiskip=\kanjiskip
        \hbox to 5zw{\inhibitglue #1\hfil}%
    @@ -3135,11 +3145,11 @@
       \kern 2.715\p@}

     \def\@makefnmark{\hbox{$^{\mbox{\tiny \kern-.5zw
    -  （\kern.1zw\@thefnmark{}）\kern-.5zw}}$}}
    +  （注\kern.1zw\@thefnmark{}）\kern-.5zw}}$}}

     \newcommand\@makefntext[1]{\parindent1zw
      \noindent\hbox{\kern-.5zw
    -  （\kern.1zw\@thefnmark{}）\kern-.5zw\hbox to 1zw{\hss ：\hss}}#1}
    +  （注\kern.1zw\@thefnmark{}）\kern-.5zw\hbox to 1zw{\hss ：\hss}}#1}

     \def\thefootnote{\@arabic\c@footnote}
     \def\thempfootnote{\@fnsymbol\c@mpfootnote}

As I mentioned in the first paragraph, I want to generate a patch that
includes both commits:

    $git diff HEAD^^ HEAD ieicej.cls
    diff --git a/ieicej.cls b/ieicej.cls
    index 1c3b947..01debd9 100644
    --- a/ieicej.cls
    +++ b/ieicej.cls
    @@ -1714,51 +1714,57 @@
       \setbox\@tempboxa\vbox{%
         \def\baselinestretch{\@titlepagebaselinestretch}%
         \hskip8mm
    -    \vtop{\footnotesize\baselineskip3mm
    -     \hbox{社団法人\hskip1zw 電子情報通信学会}%
    -     \hbox{THE INSTITUTE OF ELECTRONICS,}%
    -     \hbox{INFORMATION AND COMMUNICATION ENGINEERS}%
    -    }\hfill
    -    \vtop{\footnotesize\baselineskip3mm
    -     \hbox{信学技報}%
    -     \hbox{TECHNICAL REPORT OF IEICE.}%
    -     \hbox{}%
    -    }\hskip8mm\hbox{}\par
    +%    \vtop{\footnotesize\baselineskip3mm
    +%     \hbox{社団法人\hskip1zw 電子情報通信学会}%
    +%     \hbox{THE INSTITUTE OF ELECTRONICS,}%
    +%     \hbox{INFORMATION AND COMMUNICATION ENGINEERS}%
    +%    }\hfill
    +%    \vtop{\footnotesize\baselineskip3mm
    +%     \hbox{信学技報}%
    +%     \hbox{TECHNICAL REPORT OF IEICE.}%
    +%     \hbox{}%
    +%    }\hskip8mm\hbox{}\par
         \vskip\baselineskip
    -    \bgroup
    -     \centering
    -     {\fontsize{16}{23}\selectfont
    -      \@jtitle\par
    -     }%
    -     \vskip.25\baselineskip
    -     \ifx\@jsubtitle\empty
    -     \else
    -      {\huge
    -       \@jsubtitle\par
    -      }%
    -      \vskip.25\baselineskip
    -     \fi
    -     {\LARGE
    -       \@outputJauthorlist\par
    -     }%
    -     \vskip.5\baselineskip
    -     {\fontsize{10.5}{15}\selectfont
    -      \J@affiliate\par
    -      \Jp@affiliate\par
    -      \ifx\@MailAddress\empty
    -       \fmt@Ema
    -       \ifx\header@ma\empty
    -        \vskip.5\baselineskip
    -       \else
    - E-mail: \Mail@ddress\par
    - \vskip.5\baselineskip
    -       \fi
    -      \else
    -       E-mail: \@MailAddress
    -       \vskip.5\baselineskip
    -      \fi
    -     }%
    -    \egroup
    +%
    +% My paper doesn't have a Japanese title.
    +% The template still insists on printing author names and
affiliations in Japanese.
    +% Without a title, it author names and affiliations look kind of stupid.
    +% I think this is the part that does it, so I'm commenting it out
in an effort to reduce the amount of stupid in this paper.
    +%
    +%    \bgroup
    +%     \centering
    +%     {\fontsize{16}{23}\selectfont
    +%      \@jtitle\par
    +%     }%
    +%     \vskip.25\baselineskip
    +%     \ifx\@jsubtitle\empty
    +%     \else
    +%      {\huge
    +%       \@jsubtitle\par
    +%      }%
    +%      \vskip.25\baselineskip
    +%     \fi
    +%     {\LARGE
    +%       \@outputJauthorlist\par
    +%     }%
    +%     \vskip.5\baselineskip
    +%     {\fontsize{10.5}{15}\selectfont
    +%      \J@affiliate\par
    +%      \Jp@affiliate\par
    +%      \ifx\@MailAddress\empty
    +%       \fmt@Ema
    +%       \ifx\header@ma\empty
    +%        \vskip.5\baselineskip
    +%       \else
    +% E-mail: \Mail@ddress\par
    +% \vskip.5\baselineskip
    +%       \fi
    +%      \else
    +%       E-mail: \@MailAddress
    +%       \vskip.5\baselineskip
    +%      \fi
    +%     }%
    +%    \egroup
         \bgroup\large
          \leavevmode
          \unhbox\jabstractbox\par
    @@ -2239,8 +2245,12 @@
     \newcounter{subsubsection}[subsection]
     \newcounter{paragraph}[subsubsection]
     \newcounter{subparagraph}[paragraph]
    -\renewcommand{\thesection}{\@arabic\c@section.}
    -\renewcommand{\thesubsection}{\thesection\,\@arabic\c@subsection}
    +%
    +% Whoever thought it's a great idea to place periods after
section numbers should be shot.
    +%
    +%\renewcommand{\thesection}{\@arabic\c@section.}
    +\renewcommand{\thesection}{\@arabic\c@section}
    +\renewcommand{\thesubsection}{\thesection.\,\@arabic\c@subsection}
     \renewcommand{\thesubsubsection}{%
        \thesubsection.\,\@arabic\c@subsubsection}
     \renewcommand{\theparagraph}{% (

This looks wrong, since it doesn't include the last commit. For
example, changes to line 3145 are not there. It appears to include
changes from the second-last commit (e.g. the stuff around line 1714).

My questions:

1) What am I doing wrong?
2) How can I get the diff to include all the commits in their entirety?
3) Is this a bug?

Cheers,
Michael
