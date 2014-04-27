From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] add csharp userdiff tests
Date: Sun, 27 Apr 2014 18:19:24 +0200
Message-ID: <535D2E0C.40101@kdbg.org>
References: <29F78086-81B4-481F-9051-FF3EEBA9BB08@xamarin.com> <535B5BFF.40002@kdbg.org> <97789B23-A375-46B1-99FD-A851A15C2D85@xamarin.com> <535BF1C0.7080204@kdbg.org> <1EA6F663-54DC-4665-A88C-8627F38B356E@xamarin.com> <535BFFEB.8040103@kdbg.org> <3A0D05C9-C222-463E-BCD4-CD38F216E352@xamarin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marius Ungureanu <marius.ungureanu@xamarin.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 18:19:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeRnn-0007Aj-70
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 18:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323AbaD0QTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 12:19:32 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:13010 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754317AbaD0QTa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 12:19:30 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 5A0EEA7EB3;
	Sun, 27 Apr 2014 18:19:27 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 3D81119F434;
	Sun, 27 Apr 2014 18:19:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <3A0D05C9-C222-463E-BCD4-CD38F216E352@xamarin.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247205>

Am 27.04.2014 15:47, schrieb Marius Ungureanu:
> 
> ---

Thanks. Please signed off your patch.

When you re-send, please place [PATCH v3 n/m] in the subject (and drop
the "Re:") and note what you changed compared to the previous (or all
earlier) rounds. The place for this note is here, after the "---" marker.

Have a look at Documentation/SubmittingPatches.

>  t/t4018/csharp-constructor | 4 ++++
>  t/t4018/csharp-destructor  | 4 ++++
>  t/t4018/csharp-function    | 4 ++++
>  t/t4018/csharp-member      | 4 ++++
>  t/t4018/csharp-namespace   | 4 ++++
>  t/t4018/csharp-operator    | 4 ++++
>  t/t4018/csharp-property    | 4 ++++
>  t/t4018/csharp-skip-call   | 5 +++++
>  8 files changed, 33 insertions(+)
>  create mode 100644 t/t4018/csharp-constructor
>  create mode 100644 t/t4018/csharp-destructor
>  create mode 100644 t/t4018/csharp-function
>  create mode 100644 t/t4018/csharp-member
>  create mode 100644 t/t4018/csharp-namespace
>  create mode 100644 t/t4018/csharp-operator
>  create mode 100644 t/t4018/csharp-property
>  create mode 100644 t/t4018/csharp-skip-call
> 

Unfortunately, I think you have reduced the test cases too far. One of
the main properties of C# code is that usually member and property
definitions are indented and there is a class definition around them:

  class Foo {
     Foo(X) {}
     virtual void DoStuff() {}
     public int X;
  };

In your examples, you omitted the surrounding class definition and did
not indent the member definitions. By doing so, the test cases do not
demonstrate that the csharp userdiff patterns are significantly
different from the default userdiff pattern: in the examples you
present, the default pattern would have picked the same hunk headers as
the csharp patterns!

For a reviewer who is not (or only marginally) familiar with C# (like
myself), it would have been very instructive to present patches with
test cases that demonstrate weaknesses of the old patterns before
patches that fix them. For example, you say that you fix the constructor
pattern. But I am unable to judge what is wrong and how you fix it. The
commit message is the right place to add text that helps reviewers.

You can mark a userdiff test case that demonstrates a breakage by
including the work "broken" somewhere in the file. See
http://www.repo.or.cz/w/alt-git.git/commitdiff/9cc444f0570b196f1c51664ce2de1d8e1dee6046

> diff --git a/t/t4018/csharp-constructor b/t/t4018/csharp-constructor
> new file mode 100644
> index 0000000..a39cffb
> --- /dev/null
> +++ b/t/t4018/csharp-constructor
> @@ -0,0 +1,4 @@
> +MyClass(RIGHT)
> +{
> +	ChangeMe;
> +}
> diff --git a/t/t4018/csharp-destructor b/t/t4018/csharp-destructor
> new file mode 100644
> index 0000000..55106d9
> --- /dev/null
> +++ b/t/t4018/csharp-destructor
> @@ -0,0 +1,4 @@
> +~MyClass(RIGHT)
> +{
> +	ChangeMe;
> +}
> diff --git a/t/t4018/csharp-function b/t/t4018/csharp-function
> new file mode 100644
> index 0000000..a5d59a3
> --- /dev/null
> +++ b/t/t4018/csharp-function
> @@ -0,0 +1,4 @@
> +virtual DoStuff(RIGHT)
> +{
> +	ChangeMe;
> +}
> diff --git a/t/t4018/csharp-member b/t/t4018/csharp-member
> new file mode 100644
> index 0000000..4939d53
> --- /dev/null
> +++ b/t/t4018/csharp-member
> @@ -0,0 +1,4 @@
> +unsafe class RIGHT
> +{
> +	int ChangeMe;
> +}
> diff --git a/t/t4018/csharp-namespace b/t/t4018/csharp-namespace
> new file mode 100644
> index 0000000..6749980
> --- /dev/null
> +++ b/t/t4018/csharp-namespace
> @@ -0,0 +1,4 @@
> +namespace RIGHT
> +{
> +	ChangeMe;
> +}
> diff --git a/t/t4018/csharp-operator b/t/t4018/csharp-operator
> new file mode 100644
> index 0000000..5b00263
> --- /dev/null
> +++ b/t/t4018/csharp-operator

"csharp-user-defined-operator" would more precisely describe the case. I
wouldn't mind seening other file names being a bit more elaborate, but I
find this one particularly ambiguous.

> @@ -0,0 +1,4 @@
> +A operator+(RIGHT)
> +{
> +	ChangeMe;
> +}
> diff --git a/t/t4018/csharp-property b/t/t4018/csharp-property
> new file mode 100644
> index 0000000..82d67fc
> --- /dev/null
> +++ b/t/t4018/csharp-property
> @@ -0,0 +1,4 @@
> +public virtual int RIGHT
> +{
> +	get { ChangeMe; }
> +}
> diff --git a/t/t4018/csharp-skip-call b/t/t4018/csharp-skip-call
> new file mode 100644
> index 0000000..e89d083
> --- /dev/null
> +++ b/t/t4018/csharp-skip-call
> @@ -0,0 +1,5 @@
> +virtual void RIGHT()
> +{
> +	call();
> +	ChangeMe;
> +}

In this last test case, you want to demonstrate that the line "call()"
is not picked as hunk header. As written, the line would never be picked
as hunk header, even if it would match some pattern, because it is too
close to "ChangeMe". You must have at least one more line between
"call()" and "ChangeMe".

BTW, what is the expected hunk header in a diff like the following where
"class Foo" is at line 1 in the file (just above the hunk)?

@@ -2,3 +2,3 @@
 {
-   // old comment
+   // new comment
    public whatever()

That is, when the class definition is undecorated (no "unsafe" etc.)

-- Hannes
