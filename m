Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C72C6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 06:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjCWGjD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 02:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCWGjA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 02:39:00 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC1135B0
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 23:38:58 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j13so20640323pjd.1
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 23:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679553538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBmlVB0wii01H9AXh3pEHjdzbXgrzszc9kBh363851s=;
        b=WDbXom/z0PrSz1waWvlm6Kk8e8jBCJAes0Pbw1RtGSba3JnGpQYPZMe0eXDZpDV/Ct
         hMAtZJ2WgFez/SpFrAxzZaiQhuTwjC1ZWGfAwiGDfkWSnNgm0EJ8YRT+WwzigGn/uyaK
         QcilpV+Gdj0iLDq1PKYlP7idEV/1lChA6+fqzEBnMh2fHQSpvVqajpPmUiBlF38+4HC6
         Ql5JLhpbP8jOpEC7AOX/IHIsRDTWWFhzs2PESKuW4m968l/0mDYRqmlUeG702hBDOrc9
         S9luzGylNHUT0wGvdjUyRUq5EKMP1WVfttmY5v2/gqIdTtGf28H9cCupPXEt/LMGDsy9
         hWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679553538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBmlVB0wii01H9AXh3pEHjdzbXgrzszc9kBh363851s=;
        b=2+R+3TGjC/7JfYPkAq+d7eUC94Wjt3mMMeioh8LBp0k/2Xm8VKrqCU5nyyeJdoiqW9
         ugyhIznRtBRviXPXNHxuCCh+OHk8wLf57EcBnRzdhfK4RAD2aeUNGXXENoWIdo3riHQg
         cUXFJigh1hxh+MyEGThb4MT2BTuC+vbv9qvFkrkxqa2Hq+nc1+sWJXWexfF3DzwuLSNX
         cSgboKBJf21hL6M9fG9dXxC44m5Gjf/pUCKaOyAj7By+MaCFGBKkVissNDeExovSFlIP
         hNj3GJ03EmqUR+O//UYRn2QGhTlRMUCqiLPL4V6Dwiq5ym6Tk5c2iO34ZLRiwU2Z1DWD
         a0XQ==
X-Gm-Message-State: AO0yUKX7fTmNN+Ki4VLbw4GtLMwaSK9WP3OjBLnA4beoE2UcUh7V5CFb
        3fv3OEqW9+JYBb8I9/xZ/pwmPxYtMbU=
X-Google-Smtp-Source: AK7set/mHcEIaiWLidggmUPLXxUog3MPHc0/4drGAE7huG5On3njrC9cHr6oLD+XMlwz7X2zteJ+Eg==
X-Received: by 2002:a17:90b:1bc6:b0:23f:aa16:bdd9 with SMTP id oa6-20020a17090b1bc600b0023faa16bdd9mr6727435pjb.44.1679553537618;
        Wed, 22 Mar 2023 23:38:57 -0700 (PDT)
Received: from Vivans-MBP.lan ([2001:56a:740f:7b00:7111:ea10:326:bf9f])
        by smtp.gmail.com with ESMTPSA id z3-20020a17090ad78300b0020b21019086sm3730159pju.3.2023.03.22.23.38.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Mar 2023 23:38:56 -0700 (PDT)
From:   Vivan Garg <gvivan6@gmail.com>
To:     git@vger.kernel.org, vdye@github.com
Cc:     christian.couder@gmail.com, hariom18599@gmail.com,
        Vivan Garg <gvivan6@gmail.com>
Subject: [RFC][PATCH v3] GSoC 2023 proposal: more sparse index integration
Date:   Thu, 23 Mar 2023 00:38:44 -0600
Message-Id: <20230323063844.23222-1-gvivan6@gmail.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230226083347.80519-1-gvivan6@gmail.com>
References: <20230226083347.80519-1-gvivan6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Vivan Garg <gvivan6@gmail.com>
---
 .../More-Sparse-Index-Integrations.txt        | 319 ++++++++++++++++++
 1 file changed, 319 insertions(+)
 create mode 100644 Documentation/More-Sparse-Index-Integrations.txt

diff --git a/Documentation/More-Sparse-Index-Integrations.txt b/Documentation/More-Sparse-Index-Integrations.txt
new file mode 100644
index 0000000000..a1812b4e64
--- /dev/null
+++ b/Documentation/More-Sparse-Index-Integrations.txt
@@ -0,0 +1,319 @@
+# More Sparse Index Integrations
+
+# Personal Information
+
+Full name: Vivan Garg
+
+E-mail: gvivan6@gmail.com 
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
+I've chosen the "More Sparse Index Integrations" project idea from the
+SoC 2023 Ideas page. The goal of this project is to integrate the 
+experimental "sparse-index" feature and "sparse-checkout" command with 
+existing Git commands. 
+
+Git 2.25.0 introduced a new experimental `git sparse-checkout` command, 
+which simplified the existing feature and improved performance for 
+large repositories. It allows users to restrict their working directory 
+to only the files they care about, allowing them to ensure the developer 
+workflow is as fast as possible while maintaining all the benefits of a 
+monorepo. 
+(Bring your monorepo down to size with sparse-checkout [1], Stolee).
+
+The pattern matching process in Git's sparse-checkout feature becomes 
+expensive as the sparse-checkout file and repository size increase, 
+growing quadratically. This can result in billions of pattern checks 
+for large repositories. However, Git's new mechanism for matching based 
+on folder prefix matches drops the quadratic growth, matching M patterns 
+across N files in O(M+N*d) time, where d is the maximum folder depth of a file. 
+To further optimize the matching process, Git inspects files in a sorted 
+order instead of an arbitrary order. When Git evaluates a file path, it 
+checks whether the start of the folder path matches a recursive pattern exactly. 
+If so, it marks everything in that folder as "included" without doing any further 
+hashset lookups. Similarly, when Git detects the start of a folder that's outside 
+of the specified cone, it marks everything in that folder as "excluded" without 
+doing any further hashset lookups. This reduces the time to be closer to O(M+N) 
+(Bring your monorepo down to size with sparse-checkout [1], Stolee).
+
+[1]: https://github.blog/2020-01-17-bring-your-monorepo-down-to-size-with-sparse-checkout/
+
+The Git Fundamentals team at GitHub has contributed a new feature to Git called 
+the sparse index, which allows the index to focus on the files within the 
+sparse-checkout cone in a monorepo. The sparse index stores only the information 
+about the files within the sparse-checkout definition, instead of storing information 
+for every file at HEAD, which can make the index much larger in a monorepo. When 
+enabled with other performance features, the sparse index can have a significant 
+impact on performance (Make your monorepo feel small with Git’s sparse index [2], Stolee).
+
+[2]: https://github.blog/2021-11-10-make-your-monorepo-feel-small-with-gits-sparse-index/
+
+The sparse index differs from a normal "full" index in that it can store directory 
+paths with the object ID for its tree object. It can be used to determine if an 
+entire directory is out of the sparse-checkout cone and replace all of its contained 
+file paths with a single directory path. The use of sparse index can significantly 
+reduce the size of the index, resulting in faster operations 
+(Make your monorepo feel small with Git’s sparse index [3], Stolee).
+
+[3]: https://github.blog/2021-11-10-make-your-monorepo-feel-small-with-gits-sparse-index/
+
+Because "sparse-checkout" and "sparse-index" may potentially influence the logics of 
+other Git commands and the internal data structure of Git, some work is required to 
+optimize compatibility and user experience. That is exactly what my chosen idea proposed.
+
+## Benefits to Community
+
+By joining the community and working on this idea, I can collaborate with my mentor 
+and fellow community members to improve the user experience for people who are working 
+with large monorepos. Furthermore, I am committed to continuing my involvement beyond 
+the GSoC program, not only by contributing to the community but also by sharing my 
+experiences and mentoring future potential newcomers.
+
+
+## Microproject
+
+t4121: modernize test style [4]
+Status: WIP
+Description: Test scripts in file t4121-apply-diffs.sh are written in old style, 
+where the test_expect_success command and test title are written on
+separate lines. Therefore update the tests to adhere to the new style.
+
+## Other Contributions
+
+### Reviewing
+
+t9700: modernize test script [5]
+Status: WIP
+Description: I reviewed this patch and pointed the contributor in the right direction 
+by providing examples, links and mentioning the best practices.
+
+### Patches
+
+MyFirstContribution: add note about SMTP server config [6]
+Status: WIP
+Description: The documentation on using git-send-email previously mentioned the need 
+to configure git for your operating system and email provider, but did not provide 
+specific details on the relevant configuration settings. This commit adds a note 
+specifying that the relevant settings can be found under the 'sendemail' section of 
+Git's configuration file, with a link to the relevant documentation. The aim is to 
+provide users with a more complete understanding of the configuration process and 
+help them avoid potential roadblocks in setting up git-send-email.
+
+[4]: https://lore.kernel.org/git/CACzddJrZ8YdJ72ng3UpMGN9CJx0qW1+fZfyi3q01z2487V8fxw@mail.gmail.com/T/#md53157af31a3f347dd899679fafdea7fcaf7ecfc
+[5]: https://lore.kernel.org/git/CADupsJPpZnjA=Pu_RZZZXy7Titj3UD7ppww48KvcHHHbrGx=rw@mail.gmail.com/T/#m122db9bdca463c12f0b9ccb259fd1d3229d75945
+[6]: https://lore.kernel.org/git/20230222011317.97943-1-gvivan6@gmail.com/
+
+
+### Related Work
+
+Prior works on the idea have been completed by my mentors and other community members, 
+and these works provide a good approximation of the approach I intend to take. Here 
+are some previous examples of commits:
+
+Integration with “mv” [7]
+Integration with “reset” [8]
+Integration with “sparse-checkout” [9]
+Integration with “clean” [10]
+Integration with “blame” [11]
+
+[7]: https://lore.kernel.org/git/20220331091755.385961-1-shaoxuan.yuan02@gmail.com/
+[8]: https://lore.kernel.org/git/pull.1048.v6.git.1638201164.gitgitgadget@gmail.com/
+[9]: https://lore.kernel.org/git/pull.1208.v3.git.1653313726.gitgitgadget@gmail.com/
+[10]: https://github.com/git/git/commit/1e9e10e04891a13e5ccd52b36cfadc55dfaa5066
+[11]: https://github.com/git/git/commit/add4c864b60766174ad4f74ba7be17e66d61ef16
+
+# In GSoC
+
+## Plan
+
+Plan
+
+The proposed idea of increasing "sparse-index" integrations may appear straightforward 
+initially. However, after reviewing previous implementations, I have found that this 
+idea can present unforeseen difficulties for some functions. For example, to enable 
+"sparse-index," we must ensure that "sparse-checkout" is compatible with the target 
+Git command. Achieving this compatibility requires modifying the original command 
+logic, which can lead to other unanticipated issues. Therefore, I have incorporated 
+additional steps in the plan, to the steps proposed by the community and mentors, 
+outlined below to proactively address potential complications.
+
+1.	Conduct an investigation to determine if a Git command functions properly with 
+    sparse-checkout. This step is estimated to take approximately 7-14 days.
+
+2.	Modify the logic of the Git command, if necessary, to ensure it functions 
+    properly with sparse-checkout. Develop corresponding tests to validate the 
+    modifications. This step is estimated to take approximately 7-14 days.
+
+3.	Add tests to t1092-sparse-checkout-compatibility.sh for the built-in, focusing 
+    on what happens for paths outside of the sparse-checkout cone.
+
+4.	Disable the command_requires_full_index setting in the built-in and ensure 
+    the tests pass.
+
+5.	If the tests do not pass, then alter the logic to work with the sparse index.
+
+6.	Add tests to check that a sparse index stays sparse.
+
+7.	Add performance tests to demonstrate speedup.
+
+8.	If any changes are made that affect the behavior of the Git command, update 
+    the documentation accordingly. Note that such changes should be rare.
+
+Points 3-8 combined should take approximately 15-30 days.
+
+To summarize, each integration will follow a similar schedule to the one outlined 
+above. Therefore, without extending the timeline, we can expect to complete 2-3 i
+ntegrations during the GSoC program period.
+
+Timeline 
+
+Determining the exact time arrangement for each integration is difficult, as there 
+may be unforeseen challenges that arise during the process. However, based on my 
+estimation, I anticipate that each integration will take approximately 1.5 - 2 months 
+to complete, starting from May 29th. Please refer to the detailed breakdown of each 
+step in the plan section for a more accurate estimate.
+The proposed integration schedule is as follows:
+
+•	git describe
+•	git write-tree
+•	git diff-files
+
+This schedule is based on the order of difficulty outlined in GSoC 2023 Ideas.
+
+It's worth noting that each integration may require different amounts of time 
+and attention, and modifications to the schedule may be necessary as I delve 
+deeper into each command. Nevertheless, I am committed to delivering quality 
+results within the given timeframe.
+
+In summary, I anticipate that each integration will take an average of 1.5 months, 
+but I remain flexible and open to adjusting the schedule as needed to ensure the 
+success of the project.
+	
+Availability
+
+I commit to responding to all communication daily and being available throughout 
+the duration of the program. While I will be taking some summer courses at my 
+university, I will not be enrolled in a typical full course load. As part of GSOC, 
+I plan to commit to a medium-sized project of 175 hours. I have experience managing 
+my time effectively while taking courses and working full-time internships in the 
+past.
+
+The program is officially 16 weeks long. To ensure timely completion of the project, 
+I plan to spend 8 hours per week until August 15th, which is when my semester ends. 
+From August 16th until September 1st, I plan to dedicate 8 hours per day to the project. 
+There are only three weeks during which I would prefer to focus on other things: 
+June 23rd-30th (midterm week) and August 1st-15th (finals season). However, as I will be 
+committing 8 hours per day following Aug 15th, it should be ample enough to make up for it.
+
+I am confident that I will have ample time to complete the project within the allocated 
+time frame. Additionally, I am hoping to continue working on the project even after 
+GSOC ends, as there are several functions that need to be implemented.
+
+
+# After GSoC
+
+I recognize the value of having our GSoC participants continue to engage with 
+our community beyond the event. This is why I am committed to doing so myself. 
+Participating in open-source projects, especially with a community that supports 
+a widely-used development tool, is not only cool but also offers an opportunity 
+to learn and grow. By continuing to participate in this community, I believe 
+that I can make important contributions and continue to develop my skills.
+
+I am planning to establish an open source club at my university in the near 
+future. The University of Waterloo is known for its strong emphasis on 
+computer science and engineering, earning it the nickname "MIT of the North." 
+Given this, I believe that there will be a great deal of interest in the club 
+for a variety of reasons. Currently, there is another club called Blueprint 
+that provides a valuable opportunity for real-world development experience 
+through developing software products for charities. However, the entry process 
+for this club is extremely competitive. By contrast, I think that an open source 
+club would offer a similar experience but with a lower barrier to entry, thus 
+making it accessible to more motivated students. Additionally, given the 
+widespread use and vibrant community of Git, I plan to direct students to this 
+community and am confident that many will be interested in contributing to its 
+open source projects.
+
+# Some Credits to Myself
+
+I’ve previously completed three software developer internships and worked 
+with small startups to large sized companies. I am currently interning 
+with Morgan Stanley and am on the architecture team, working on a large 
+scale equity management software. 
+
+I'm interested in open source development as a way to give back to the 
+community while also growing as a developer. My background in C programming 
+language has made me particularly interested in contributing to Git, which 
+is primarily written in C. I am also comfortable with concepts like memory 
+allocation, thanks to my experience with C programming. Furthermore, I have 
+studied shell scripting as part of my coursework, which makes me well-equipped
+to handle the project's language requirements. Another personal motivation 
+for contributing to this project is that I have worked with monorepos before, 
+and given that it is used by many of the larger tech companies, I want to 
+learn more about it and help improve the user experience with it.
+
+Victoria mentioned that I was the first person to express interest in the 
+project this year, either directly or via the mailing list. In my spare time, 
+I've been contributing and reading documents while also working a full-time 
+job (internship) and taking one course at my university. I expect to have a 
+lot more time next term, so you can expect even more from me ;). Nonetheless, 
+I became familiar and comfortable with the contribution process by writing, 
+responding to, and auditing various types of patches in the community.
+
+With the patches I have submitted so far, I have been able to develop a deeper 
+understanding of Git internals, project structures, commonly used APIs, test 
+suites, required tech stacks, and coding guidelines. To further enhance my 
+comprehension of Git, I have either read or skimmed through several relevant 
+documents, including 'Submitting patches', 'Coding guidelines', 
+'Myfirstcontribution.txt', 'Git tutorial', 'Git everyday', 'readme', 
+'Hacking Git', drawing upon my prior knowledge where applicable. Additionally, 
+I have been referring to the book 'Pro Git' on an as-needed basis. Furthermore, 
+I have thoroughly read and referenced blogs such as 'Make your monorepo feel 
+small with Git's sparse index [12]', 'Bring your monorepo down to size with 
+sparse-checkout [13]', and 'Commits are snapshots, not diffs [14]'. The 
+advantage of having prior knowledge and experience with my proposed project 
+idea is that I am well-prepared to tackle any upcoming challenges.
+
+[12]: https://github.blog/2021-11-10-make-your-monorepo-feel-small-with-gits-sparse-index/
+[13]: https://github.blog/2020-01-17-bring-your-monorepo-down-to-size-with-sparse-checkout/
+[14]: https://github.blog/2020-12-17-commits-are-snapshots-not-diffs/
+
+# Closing remarks
+
+I am very motivated for this project because I have previously worked with 
+monorepos and will most likely have to work with them again in my future 
+internships. As a result, I intend to continue working on remaining c
+ommands after GSOC whenever I have free time. 
+
+I'd like to state that I'm a genuinely enthusiastic open-source newcomer 
+who is very much looking forward to this opportunity. I am grateful for 
+the opportunity to contribute to Git's development, and I am committed to 
+working diligently to strengthen the open-source ecosystem. My ultimate goal 
+is to use this opportunity to bring new energy and ideas to the table, and to 
+make meaningful contributions that benefit the entire community.
+
+I am grateful for the community's support, especially Victoria's guidance 
+and feedback. She promptly replied to my inquiries and provided me with 
+several resources that were instrumental in helping me get started on the 
+project. I am truly humbled by the dedication and hard work that the 
+community puts in to nurture and enhance this ecosystem, and I feel 
+fortunate to have received such warm and welcoming support as a new 
+contributor. It is an honor to be a part of this community and to 
+work towards advancing its mission.
+
+Thank you so much for reading through my proposal!
+
+Kind Regards,
+Vivan Garg
+
-- 
2.37.0 (Apple Git-136)

