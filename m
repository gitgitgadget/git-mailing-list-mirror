Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40119C64ED6
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 08:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjBZIeK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 03:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBZIeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 03:34:09 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983401420B
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 00:34:07 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id z10so1874643pgr.8
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 00:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cjo1J3XbENdcP4x2V6rFcMNYN6+mssi6l9/vq+VFyPc=;
        b=kCA6saduK0onu9xSDXj45ouMgOtLuaz/6hbPfCK2v9zzfe5VeHU4/x3QNB3n1OwPMd
         pOJxvPxvPRzdISamAHTzDU1dAzf4PZ4lUfBWNKp+/lR/aFnkz82ijLU8s8fj7nWEqPjM
         U6veFVdDmacNW++1wdiVJaMY1gUYlBtZP9JhRBIS/SSxOkfKY3jUYftPZEMZOOklZ9//
         b1RsG1rHrRwJdruOOZlUG+akXKSgDRtYWqbOT1E7vKF9KINr8ce1xluRAK2wLinhqeit
         T8AtLg7cB2RFjOklIRgyvOBAH/EhGS12+N00FEdxHoMVtuYSagkgNgReuz9J8t0pNrqN
         s5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cjo1J3XbENdcP4x2V6rFcMNYN6+mssi6l9/vq+VFyPc=;
        b=5QzS04xuyfrZYJQcuWo0os+MiticiCix94i/xK/eElEn98ESevL/kyFbDx2W7ti3Vx
         KqjmTZPxhFb1X4Ovzw2CWGeQ9XDwMJtndE7IYiVbI7s3YS740l47YG2TpLVoCljWB8r/
         dvA11SLYD0WGewFZ0k6VCiSuQQMaSEhlesqOR8KT04oO4aR86lqQtLgoTJrmtHHiB+5U
         hO19ewgY3QKS6LSE4zN7ssj7XChwiV7YzQK6iDYW/flO8mHZZANCldgyugID9t3Ruklf
         r1UHXUt6BUUYNDgFXztvXIoRXTlTBXpZec2UD2ZlZ50YKzulo0OT8nT90yxUktgYr2ZG
         7lVQ==
X-Gm-Message-State: AO0yUKUGY63V7rDwthH1v7Uv2ZbUhbJDTps7OjOqlZAjKXJA9bXyyRfa
        2l2Q6h5szx9tNCVj+bkobKVnP2wPdOg=
X-Google-Smtp-Source: AK7set8r6fJO99LqWEMwuOQraWRQjoGZDT8GusVBasH63Yp+bbAEgVa4ZPemVbyrg2sAiraupYJshQ==
X-Received: by 2002:aa7:97a3:0:b0:5a9:c535:dba3 with SMTP id d3-20020aa797a3000000b005a9c535dba3mr21565995pfq.25.1677400446510;
        Sun, 26 Feb 2023 00:34:06 -0800 (PST)
Received: from Vivans-MBP.lan (node-1w7jr9y92i5dh9726pfew2f2i.ipv6.telus.net. [2001:56a:740f:7b00:9da5:2d3:e60f:ca])
        by smtp.gmail.com with ESMTPSA id j23-20020aa783d7000000b005ac86f7b87fsm2144690pfn.77.2023.02.26.00.34.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Feb 2023 00:34:06 -0800 (PST)
From:   Vivan Garg <gvivan6@gmail.com>
To:     git@vger.kernel.org, vdye@github.com
Cc:     christian.couder@gmail.com, hariom18599@gmail.com,
        Vivan Garg <gvivan6@gmail.com>
Subject: [RFC][PATCH] GSoC 2023 proposal: more sparse index integration
Date:   Sun, 26 Feb 2023 01:33:47 -0700
Message-Id: <20230226083347.80519-1-gvivan6@gmail.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Vivan Garg <gvivan6@gmail.com>
---
This is a rough draft of my proposal for the GSoC 2023 more sparse=20
index integration project. I would greatly appreciate any feedback=20
anyone has to offer. Thank you in advance!

 .../More-Sparse-Index-Integrations.txt        | 134 ++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 Documentation/More-Sparse-Index-Integrations.txt

diff --git a/Documentation/More-Sparse-Index-Integrations.txt b/Documentati=
on/More-Sparse-Index-Integrations.txt
new file mode 100644
index 0000000000..dbe6da660f
--- /dev/null
+++ b/Documentation/More-Sparse-Index-Integrations.txt
@@ -0,0 +1,134 @@
+# More Sparse Index Integrations
+
+# Personal Information
+
+Full name: Vivan Garg
+
+E-mail: gvivan6@gmail.com=20
+Alternate E-mail: v.garg.work@gmail.com
+Tel: (+1)437-987-2678
+
+Education: University of Waterloo (Canada)
+Major: Computer Science and Financial Management (Double-Major)
+Year: Rising Junior
+
+LinkedIn: https://www.linkedin.com/in/gvivan/
+GitHub: https://github.com/gvivan
+Website: https://gvivan.me/
+
+# Before GSoC
+
+## Synopsis
+
+I've chosen the "More Sparse Index Integrations" project idea from the SoC=
 2023 Ideas page. The goal of this project is to integrate the experimental=
 "sparse-index" feature and "sparse-checkout" command with existing Git com=
mands.=20
+
+Git 2.25.0 introduced a new experimental `git sparse-checkout` command, wh=
ich simplified the existing feature and improved performance for large repo=
sitories. It allows users to restrict their working directory to only the f=
iles they care about, allowing them to ensure the developer workflow is as =
fast as possible while maintaining all the benefits of a monorepo.=20
+(Bring your monorepo down to size with sparse-checkout, Stolee).
+
+The pattern matching process in Git's sparse-checkout feature becomes expe=
nsive as the sparse-checkout file and repository size increase, growing qua=
dratically. This can result in billions of pattern checks for large reposit=
ories. However, Git's new mechanism for matching based on folder prefix mat=
ches drops the quadratic growth, matching M patterns across N files in O(M+=
N*d) time, where d is the maximum folder depth of a file.=20
+To further optimize the matching process, Git inspects files in a sorted o=
rder instead of an arbitrary order. When Git evaluates a file path, it chec=
ks whether the start of the folder path matches a recursive pattern exactly=
. If so, it marks everything in that folder as "included" without doing any=
 further hashset lookups. Similarly, when Git detects the start of a folder=
 that's outside of the specified cone, it marks everything in that folder a=
s "excluded" without doing any further hashset lookups. This reduces the ti=
me to be closer to O(M+N) (Bring your monorepo down to size with sparse-che=
ckout, Stolee).
+
+The Git Fundamentals team at GitHub has contributed a new feature to Git c=
alled the sparse index, which allows the index to focus on the files within=
 the sparse-checkout cone in a monorepo. The sparse index stores only the i=
nformation about the files within the sparse-checkout definition, instead o=
f storing information for every file at HEAD, which can make the index much=
 larger in a monorepo. When enabled with other performance features, the sp=
arse index can have a significant impact on performance (Make your monorepo=
 feel small with Git=E2=80=99s sparse index, Stolee).
+
+The sparse index differs from a normal "full" index in that it can store d=
irectory paths with the object ID for its tree object. It can be used to de=
termine if an entire directory is out of the sparse-checkout cone and repla=
ce all of its contained file paths with a single directory path. The use of=
 sparse index can significantly reduce the size of the index, resulting in =
faster operations (Make your monorepo feel small with Git=E2=80=99s sparse =
index, Stolee).
+
+Because "sparse-checkout" and "sparse-index" may potentially influence the=
 logics of other Git commands and the internal data structure of Git, some =
work is required to optimize compatibility and user experience. That is exa=
ctly what my chosen idea proposed.
+
+## Benefits to Community
+
+By joining the community and working on this idea, I can collaborate with =
my mentor and fellow community members to improve the user experience for p=
eople who are working with large monorepos. Furthermore, I am committed to =
continuing my involvement beyond the GSoC program, not only by contributing=
 to the community but also by sharing my experiences and mentoring future p=
otential newcomers.
+
+
+## Microproject
+
+t4121: modernize test style
+Status: ready to merge
+Description: Test scripts in file t4121-apply-diffs.sh are written in old =
style,where the test_expect_success command and test title are written on
+separate lines. Therefore update the tests to adhere to the new style.
+
+## Other Contributions
+
+### Reviewing
+
+t9700: modernize test script
+Status: WIP
+Description: I reviewed this patch and pointed the contributor in the righ=
t direction by providing examples, links and mentioning the best practices.
+
+### Patches
+
+MyFirstContribution: add note about SMTP server config
+Status: WIP
+Description: The documentation on using git-send-email previously mentione=
d the need to configure git for your operating system and email provider, b=
ut did not provide specific details on the relevant configuration settings.=
 This commit adds a note specifying that the relevant settings can be found=
 under the 'sendemail' section of Git's configuration file, with a link to =
the relevant documentation. The aim is to provide users with a more complet=
e understanding of the configuration process and help them avoid potential =
roadblocks in setting up git-send-email.
+
+
+### Related Work
+
+Prior works on the idea have been completed by my mentors and other commun=
ity members, and these works provide a good approximation of the approach I=
 intend to take. Here are some previous examples of commits:
+Integration with =E2=80=9Cmv=E2=80=9D
+Integration with =E2=80=9Creset=E2=80=9D
+Integration with =E2=80=9Csparse-checkout=E2=80=9D
+Integration with =E2=80=9Cclean=E2=80=9D
+Integration with =E2=80=9Cblame=E2=80=9D
+
+# In GSoC
+
+## Plan
+
+The proposed idea of increasing "sparse-index" integrations may seem strai=
ghtforward at first glance. However, upon reviewing previous implementation=
s, I discovered that this idea can introduce unforeseen difficulties for so=
me functions. For example, to enable "sparse-index," we must ensure that "s=
parse-checkout" is compatible with the target Git command. Achieving this c=
ompatibility requires modifying the original command logic, which can lead =
to other unanticipated issues. Therefore, I have incorporated some addition=
al steps in the plan outlined below to proactively address potential compli=
cations. It's worth noting that points 3-7 are part of the SoC 2023 Ideas p=
roposed by the community and mentors.
+
+1. Conduct an investigation to determine if a Git command functions proper=
ly with sparse-checkout.
+
+2. Modify the logic of the Git command, if necessary, to ensure it functio=
ns properly with sparse-checkout. Develop corresponding tests to validate t=
he modifications.=20
+
+3. Add tests to t1092-sparse-checkout-compatibility.sh for the builtin, wi=
th a focus on what happens for paths outside of the sparse-checkout cone.
+
+4. Disable the command_requires_full_index setting in the builtin and ensu=
re the tests pass.
+
+5. If the tests do not pass, then alter the logic to work with the sparse =
index.
+
+6. Add tests to check that a sparse index stays sparse.
+
+7. Add performance tests to demonstrate speedup.
+
+8. If any changes are made that affect the behavior of the Git command, up=
date the documentation accordingly. Note that such changes should be rare.
+
+## Timeline
+
+During my discussion with Victoria, she informed me that given my commitme=
nt of 175 hours, it is expected that I will be able to fully integrate two =
commands with sparse index during the GSOC program. My plan is to evenly di=
stribute the work for each command over the course of the program. I am con=
fident that I can start the project early as I have already established com=
munication with my mentors and familiarized myself with the related documen=
tation, although my understanding may not be comprehensive.
+
+Based on my prior experience with the idea, I believe I will be able to qu=
ickly get up to speed and begin working on the project. The exact timeline =
for each integration is difficult to determine, but I estimate that I shoul=
d be able to complete one integration every two months. I have already plan=
ned out my next term, and there are only three weeks during which I would p=
refer to focus on other things: June 23-30 and August 1-15. However, even w=
ithout an extension, I should be able to manage this timeline. With the fle=
xibility to extend the program, it should be even easier to accommodate any=
 potential scheduling conflicts.=09
+
+=09
+## Availability
+
+I will respond to all communication daily and will be available throughout=
 the duration of the program. Although I will be taking some summer courses=
 at my university, I will not be enrolled in a typical full course load. As=
 part of GSOC, I plan to commit to 175 hours. I have experience managing my=
 time effectively while taking courses and working full-time internships in=
 the past. My semester ends on August 15th, and I have no commitments for t=
he following month, which allows me to continue working beyond the end of t=
he semester. With the flexibility to extend the timeline of GSOC, I am conf=
ident that I will have ample time to complete the project. I have already d=
iscussed this with Victoria, the mentor for the project, and she has agreed=
 to extend the deadline until October 2nd, if necessary. After August 15th,=
 I will be able to work at least 8 hours per day, totaling ~360 hours of wo=
rk until the October 2nd deadline. This exceeds the required commitment of =
175 hours, ensuring that I will complete the project on time. Additionally,=
 I am hoping to continue working on the project even after GSOC ends.=20
+
+# After GSoC
+
+I recognize the value of having our GSoC participants continue to engage w=
ith our community beyond the event. This is why I am committed to doing so =
myself. Participating in open-source projects, especially with a community =
that supports a widely-used development tool, is not only cool but also off=
ers an opportunity to learn and grow. By continuing to participate in this =
community, I believe that I can make important contributions and continue t=
o develop my skills.
+
+I am planning to establish an open source club at my university in the nea=
r future. The University of Waterloo is known for its strong emphasis on co=
mputer science and engineering, earning it the nickname "MIT of the North."=
 Given this, I believe that there will be a great deal of interest in the c=
lub for a variety of reasons. Currently, there is another club called Bluep=
rint that provides a valuable opportunity for real-world development experi=
ence through developing software products for charities. However, the entry=
 process for this club is extremely competitive. By contrast, I think that =
an open source club would offer a similar experience but with a lower barri=
er to entry, thus making it accessible to more motivated students. Addition=
ally, given the widespread use and vibrant community of Git, I plan to dire=
ct students to this community and am confident that many will be interested=
 in contributing to its open source projects.
+
+# Some Credits to Myself
+
+I=E2=80=99ve previously completed three software developer internships and=
 worked with small startups to large sized companies. I am currently intern=
ing with Morgan Stanley and am on the architecture team, working on a large=
 scale equity management software.=20
+
+I'm interested in open source development as a way to give back to the com=
munity while also growing as a developer. My background in C programming la=
nguage has made me particularly interested in contributing to Git, which is=
 primarily written in C. I am also comfortable with concepts like memory al=
location, thanks to my experience with C programming. Furthermore, I have s=
tudied shell scripting as part of my coursework, which makes me well-equipp=
ed to handle the project's language requirements. Another personal motivati=
on for contributing to this project is that I have worked with monorepos be=
fore, and given that it is used by many of the larger tech companies, I wan=
t to learn more about it and help improve the user experience with it.
+
+Victoria mentioned that I was the first person to express interest in the =
project this year, either directly or via the mailing list. In my spare tim=
e, I've been contributing and reading documents while also working a full-t=
ime job (internship) and taking one course at my university. I expect to ha=
ve a lot more time next term, so you can expect even more from me ;). Nonet=
heless, I became familiar and comfortable with the contribution process by =
writing, responding to, and auditing various types of patches in the commun=
ity.
+
+With the patches I have submitted so far, I have been able to develop a de=
eper understanding of Git internals, project structures, commonly used APIs=
, test suites, required tech stacks, and coding guidelines. To further enha=
nce my comprehension of Git, I have either read or skimmed through several =
relevant documents, including 'Submitting patches', 'Coding guidelines', 'M=
yfirstcontribution.txt', 'Git tutorial', 'Git everyday', 'readme', 'Hacking=
 Git', drawing upon my prior knowledge where applicable. Additionally, I ha=
ve been referring to the book 'Pro Git' on an as-needed basis. Furthermore,=
 I have thoroughly read and referenced blogs such as 'Make your monorepo fe=
el small with Git's sparse index', 'Bring your monorepo down to size with s=
parse-checkout', and 'Commits are snapshots, not diffs'. The advantage of h=
aving prior knowledge and experience with my proposed project idea is that =
I am well-prepared to tackle any upcoming challenges.
+
+# Closing remarks
+
+I am very motivated for this project because I have previously worked with=
 monorepos and will most likely have to work with them again in my future i=
nternships. As a result, I intend to continue working on remaining commands=
 after GSOC whenever I have free time.=20
+
+I'd like to state that I'm a genuinely enthusiastic open-source newcomer w=
ho is very much looking forward to this opportunity. I am grateful for the =
opportunity to contribute to Git's development, and I am committed to worki=
ng diligently to strengthen the open-source ecosystem. My ultimate goal is =
to use this opportunity to bring new energy and ideas to the table, and to =
make meaningful contributions that benefit the entire community.
+
+I am grateful for the community's support, especially Victoria's guidance =
and feedback. She promptly replied to my inquiries and provided me with sev=
eral resources that were instrumental in helping me get started on the proj=
ect. I am truly humbled by the dedication and hard work that the community =
puts in to nurture and enhance this ecosystem, and I feel fortunate to have=
 received such warm and welcoming support as a new contributor. It is an ho=
nor to be a part of this community and to work towards advancing its missio=
n.
+
+Thank you so much for reading through my proposal!
+
+Kind Regards,
+Vivan Garg
+

base-commit: d9d677b2d8cc5f70499db04e633ba7a400f64cbf
--=20
2.37.0 (Apple Git-136)

