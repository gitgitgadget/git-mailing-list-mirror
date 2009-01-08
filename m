From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 7/7] Create an automatic UI test for the Git Import Wizard
Date: Thu,  8 Jan 2009 17:56:31 +0100
Message-ID: <1231433791-9267-8-git-send-email-robin.rosenberg@dewire.com>
References: <1231433791-9267-1-git-send-email-robin.rosenberg@dewire.com>
 <1231433791-9267-2-git-send-email-robin.rosenberg@dewire.com>
 <1231433791-9267-3-git-send-email-robin.rosenberg@dewire.com>
 <1231433791-9267-4-git-send-email-robin.rosenberg@dewire.com>
 <1231433791-9267-5-git-send-email-robin.rosenberg@dewire.com>
 <1231433791-9267-6-git-send-email-robin.rosenberg@dewire.com>
 <1231433791-9267-7-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Jan 08 17:58:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKyDP-0001ZY-N2
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 17:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107AbZAHQ44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 11:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755604AbZAHQ4y
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 11:56:54 -0500
Received: from mail.dewire.com ([83.140.172.130]:25798 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752824AbZAHQ4t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 11:56:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 24A051484F6D;
	Thu,  8 Jan 2009 17:56:41 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xz4EuKCsMlE6; Thu,  8 Jan 2009 17:56:38 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id E306E1484F75;
	Thu,  8 Jan 2009 17:56:33 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc3.56.gd0306
In-Reply-To: <1231433791-9267-7-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104942>

Things like dialogs and such require a different approach. The
strategy is to use SWTBot for runnings UI-oriented tests.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 org.spearce.egit.ui.test/.classpath                |    8 +
 org.spearce.egit.ui.test/.project                  |   28 ++
 .../.settings/org.eclipse.jdt.core.prefs           |  320 +++++++++++++
 .../All org.spearce.egit.ui tests.launch           |   41 ++
 org.spearce.egit.ui.test/META-INF/MANIFEST.MF      |   19 +
 org.spearce.egit.ui.test/build.properties          |    4 +
 .../ui/internal/sharing/GitCloneWizardTest.java    |  480 ++++++++++++++++++++
 .../src/org/spearce/egit/ui/test/Activator.java    |   50 ++
 8 files changed, 950 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.egit.ui.test/.classpath
 create mode 100644 org.spearce.egit.ui.test/.project
 create mode 100644 org.spearce.egit.ui.test/.settings/org.eclipse.jdt.core.prefs
 create mode 100644 org.spearce.egit.ui.test/All org.spearce.egit.ui tests.launch
 create mode 100644 org.spearce.egit.ui.test/META-INF/MANIFEST.MF
 create mode 100644 org.spearce.egit.ui.test/build.properties
 create mode 100644 org.spearce.egit.ui.test/src/org/spearce/egit/ui/internal/sharing/GitCloneWizardTest.java
 create mode 100644 org.spearce.egit.ui.test/src/org/spearce/egit/ui/test/Activator.java

diff --git a/org.spearce.egit.ui.test/.classpath b/org.spearce.egit.ui.test/.classpath
new file mode 100644
index 0000000..76279f3
--- /dev/null
+++ b/org.spearce.egit.ui.test/.classpath
@@ -0,0 +1,8 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<classpath>
+	<classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER/org.eclipse.jdt.internal.debug.ui.launcher.StandardVMType/JavaSE-1.6"/>
+	<classpathentry kind="con" path="org.eclipse.pde.core.requiredPlugins"/>
+	<classpathentry kind="src" path="src"/>
+	<classpathentry kind="con" path="org.eclipse.jdt.junit.JUNIT_CONTAINER/3"/>
+	<classpathentry kind="output" path="bin"/>
+</classpath>
diff --git a/org.spearce.egit.ui.test/.project b/org.spearce.egit.ui.test/.project
new file mode 100644
index 0000000..caa9fa4
--- /dev/null
+++ b/org.spearce.egit.ui.test/.project
@@ -0,0 +1,28 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<projectDescription>
+	<name>org.spearce.egit.ui.test</name>
+	<comment></comment>
+	<projects>
+	</projects>
+	<buildSpec>
+		<buildCommand>
+			<name>org.eclipse.jdt.core.javabuilder</name>
+			<arguments>
+			</arguments>
+		</buildCommand>
+		<buildCommand>
+			<name>org.eclipse.pde.ManifestBuilder</name>
+			<arguments>
+			</arguments>
+		</buildCommand>
+		<buildCommand>
+			<name>org.eclipse.pde.SchemaBuilder</name>
+			<arguments>
+			</arguments>
+		</buildCommand>
+	</buildSpec>
+	<natures>
+		<nature>org.eclipse.pde.PluginNature</nature>
+		<nature>org.eclipse.jdt.core.javanature</nature>
+	</natures>
+</projectDescription>
diff --git a/org.spearce.egit.ui.test/.settings/org.eclipse.jdt.core.prefs b/org.spearce.egit.ui.test/.settings/org.eclipse.jdt.core.prefs
new file mode 100644
index 0000000..fb77da2
--- /dev/null
+++ b/org.spearce.egit.ui.test/.settings/org.eclipse.jdt.core.prefs
@@ -0,0 +1,320 @@
+#Sun Feb 03 03:52:00 CET 2008
+eclipse.preferences.version=1
+org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode=enabled
+org.eclipse.jdt.core.compiler.codegen.targetPlatform=1.5
+org.eclipse.jdt.core.compiler.codegen.unusedLocal=preserve
+org.eclipse.jdt.core.compiler.compliance=1.5
+org.eclipse.jdt.core.compiler.debug.lineNumber=generate
+org.eclipse.jdt.core.compiler.debug.localVariable=generate
+org.eclipse.jdt.core.compiler.debug.sourceFile=generate
+org.eclipse.jdt.core.compiler.doc.comment.support=enabled
+org.eclipse.jdt.core.compiler.problem.annotationSuperInterface=warning
+org.eclipse.jdt.core.compiler.problem.assertIdentifier=error
+org.eclipse.jdt.core.compiler.problem.autoboxing=warning
+org.eclipse.jdt.core.compiler.problem.deprecation=warning
+org.eclipse.jdt.core.compiler.problem.deprecationInDeprecatedCode=disabled
+org.eclipse.jdt.core.compiler.problem.deprecationWhenOverridingDeprecatedMethod=disabled
+org.eclipse.jdt.core.compiler.problem.discouragedReference=warning
+org.eclipse.jdt.core.compiler.problem.emptyStatement=warning
+org.eclipse.jdt.core.compiler.problem.enumIdentifier=error
+org.eclipse.jdt.core.compiler.problem.fallthroughCase=warning
+org.eclipse.jdt.core.compiler.problem.fieldHiding=warning
+org.eclipse.jdt.core.compiler.problem.finalParameterBound=warning
+org.eclipse.jdt.core.compiler.problem.finallyBlockNotCompletingNormally=error
+org.eclipse.jdt.core.compiler.problem.forbiddenReference=error
+org.eclipse.jdt.core.compiler.problem.hiddenCatchBlock=error
+org.eclipse.jdt.core.compiler.problem.incompatibleNonInheritedInterfaceMethod=warning
+org.eclipse.jdt.core.compiler.problem.incompleteEnumSwitch=warning
+org.eclipse.jdt.core.compiler.problem.indirectStaticAccess=error
+org.eclipse.jdt.core.compiler.problem.invalidJavadoc=error
+org.eclipse.jdt.core.compiler.problem.invalidJavadocTags=enabled
+org.eclipse.jdt.core.compiler.problem.invalidJavadocTagsDeprecatedRef=enabled
+org.eclipse.jdt.core.compiler.problem.invalidJavadocTagsNotVisibleRef=enabled
+org.eclipse.jdt.core.compiler.problem.invalidJavadocTagsVisibility=private
+org.eclipse.jdt.core.compiler.problem.localVariableHiding=warning
+org.eclipse.jdt.core.compiler.problem.methodWithConstructorName=error
+org.eclipse.jdt.core.compiler.problem.missingDeprecatedAnnotation=ignore
+org.eclipse.jdt.core.compiler.problem.missingJavadocComments=ignore
+org.eclipse.jdt.core.compiler.problem.missingJavadocCommentsOverriding=disabled
+org.eclipse.jdt.core.compiler.problem.missingJavadocCommentsVisibility=protected
+org.eclipse.jdt.core.compiler.problem.missingJavadocTags=error
+org.eclipse.jdt.core.compiler.problem.missingJavadocTagsOverriding=disabled
+org.eclipse.jdt.core.compiler.problem.missingJavadocTagsVisibility=private
+org.eclipse.jdt.core.compiler.problem.missingOverrideAnnotation=ignore
+org.eclipse.jdt.core.compiler.problem.missingSerialVersion=warning
+org.eclipse.jdt.core.compiler.problem.noEffectAssignment=error
+org.eclipse.jdt.core.compiler.problem.noImplicitStringConversion=error
+org.eclipse.jdt.core.compiler.problem.nonExternalizedStringLiteral=ignore
+org.eclipse.jdt.core.compiler.problem.nullReference=error
+org.eclipse.jdt.core.compiler.problem.overridingPackageDefaultMethod=warning
+org.eclipse.jdt.core.compiler.problem.parameterAssignment=warning
+org.eclipse.jdt.core.compiler.problem.possibleAccidentalBooleanAssignment=error
+org.eclipse.jdt.core.compiler.problem.potentialNullReference=warning
+org.eclipse.jdt.core.compiler.problem.rawTypeReference=ignore
+org.eclipse.jdt.core.compiler.problem.redundantNullCheck=warning
+org.eclipse.jdt.core.compiler.problem.specialParameterHidingField=disabled
+org.eclipse.jdt.core.compiler.problem.staticAccessReceiver=error
+org.eclipse.jdt.core.compiler.problem.suppressWarnings=enabled
+org.eclipse.jdt.core.compiler.problem.typeParameterHiding=warning
+org.eclipse.jdt.core.compiler.problem.uncheckedTypeOperation=warning
+org.eclipse.jdt.core.compiler.problem.undocumentedEmptyBlock=warning
+org.eclipse.jdt.core.compiler.problem.unhandledWarningToken=warning
+org.eclipse.jdt.core.compiler.problem.unnecessaryTypeCheck=error
+org.eclipse.jdt.core.compiler.problem.unqualifiedFieldAccess=ignore
+org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownException=error
+org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownExceptionWhenOverriding=disabled
+org.eclipse.jdt.core.compiler.problem.unusedImport=error
+org.eclipse.jdt.core.compiler.problem.unusedLabel=error
+org.eclipse.jdt.core.compiler.problem.unusedLocal=error
+org.eclipse.jdt.core.compiler.problem.unusedParameter=warning
+org.eclipse.jdt.core.compiler.problem.unusedParameterWhenImplementingAbstract=disabled
+org.eclipse.jdt.core.compiler.problem.unusedParameterWhenOverridingConcrete=disabled
+org.eclipse.jdt.core.compiler.problem.unusedPrivateMember=error
+org.eclipse.jdt.core.compiler.problem.varargsArgumentNeedCast=error
+org.eclipse.jdt.core.compiler.source=1.5
+org.eclipse.jdt.core.formatter.align_type_members_on_columns=false
+org.eclipse.jdt.core.formatter.alignment_for_arguments_in_allocation_expression=16
+org.eclipse.jdt.core.formatter.alignment_for_arguments_in_enum_constant=16
+org.eclipse.jdt.core.formatter.alignment_for_arguments_in_explicit_constructor_call=16
+org.eclipse.jdt.core.formatter.alignment_for_arguments_in_method_invocation=16
+org.eclipse.jdt.core.formatter.alignment_for_arguments_in_qualified_allocation_expression=16
+org.eclipse.jdt.core.formatter.alignment_for_assignment=0
+org.eclipse.jdt.core.formatter.alignment_for_binary_expression=16
+org.eclipse.jdt.core.formatter.alignment_for_compact_if=16
+org.eclipse.jdt.core.formatter.alignment_for_conditional_expression=80
+org.eclipse.jdt.core.formatter.alignment_for_enum_constants=0
+org.eclipse.jdt.core.formatter.alignment_for_expressions_in_array_initializer=16
+org.eclipse.jdt.core.formatter.alignment_for_multiple_fields=16
+org.eclipse.jdt.core.formatter.alignment_for_parameters_in_constructor_declaration=16
+org.eclipse.jdt.core.formatter.alignment_for_parameters_in_method_declaration=16
+org.eclipse.jdt.core.formatter.alignment_for_selector_in_method_invocation=16
+org.eclipse.jdt.core.formatter.alignment_for_superclass_in_type_declaration=16
+org.eclipse.jdt.core.formatter.alignment_for_superinterfaces_in_enum_declaration=16
+org.eclipse.jdt.core.formatter.alignment_for_superinterfaces_in_type_declaration=16
+org.eclipse.jdt.core.formatter.alignment_for_throws_clause_in_constructor_declaration=16
+org.eclipse.jdt.core.formatter.alignment_for_throws_clause_in_method_declaration=16
+org.eclipse.jdt.core.formatter.blank_lines_after_imports=1
+org.eclipse.jdt.core.formatter.blank_lines_after_package=1
+org.eclipse.jdt.core.formatter.blank_lines_before_field=1
+org.eclipse.jdt.core.formatter.blank_lines_before_first_class_body_declaration=0
+org.eclipse.jdt.core.formatter.blank_lines_before_imports=1
+org.eclipse.jdt.core.formatter.blank_lines_before_member_type=1
+org.eclipse.jdt.core.formatter.blank_lines_before_method=1
+org.eclipse.jdt.core.formatter.blank_lines_before_new_chunk=1
+org.eclipse.jdt.core.formatter.blank_lines_before_package=0
+org.eclipse.jdt.core.formatter.blank_lines_between_type_declarations=1
+org.eclipse.jdt.core.formatter.brace_position_for_annotation_type_declaration=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_anonymous_type_declaration=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_array_initializer=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_block=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_block_in_case=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_constructor_declaration=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_enum_constant=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_enum_declaration=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_method_declaration=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_switch=end_of_line
+org.eclipse.jdt.core.formatter.brace_position_for_type_declaration=end_of_line
+org.eclipse.jdt.core.formatter.comment.clear_blank_lines=false
+org.eclipse.jdt.core.formatter.comment.format_comments=true
+org.eclipse.jdt.core.formatter.comment.format_header=false
+org.eclipse.jdt.core.formatter.comment.format_html=true
+org.eclipse.jdt.core.formatter.comment.format_source_code=true
+org.eclipse.jdt.core.formatter.comment.indent_parameter_description=true
+org.eclipse.jdt.core.formatter.comment.indent_root_tags=true
+org.eclipse.jdt.core.formatter.comment.insert_new_line_before_root_tags=insert
+org.eclipse.jdt.core.formatter.comment.insert_new_line_for_parameter=insert
+org.eclipse.jdt.core.formatter.comment.line_length=80
+org.eclipse.jdt.core.formatter.compact_else_if=true
+org.eclipse.jdt.core.formatter.continuation_indentation=2
+org.eclipse.jdt.core.formatter.continuation_indentation_for_array_initializer=2
+org.eclipse.jdt.core.formatter.format_guardian_clause_on_one_line=false
+org.eclipse.jdt.core.formatter.indent_body_declarations_compare_to_annotation_declaration_header=true
+org.eclipse.jdt.core.formatter.indent_body_declarations_compare_to_enum_constant_header=true
+org.eclipse.jdt.core.formatter.indent_body_declarations_compare_to_enum_declaration_header=true
+org.eclipse.jdt.core.formatter.indent_body_declarations_compare_to_type_header=true
+org.eclipse.jdt.core.formatter.indent_breaks_compare_to_cases=true
+org.eclipse.jdt.core.formatter.indent_empty_lines=false
+org.eclipse.jdt.core.formatter.indent_statements_compare_to_block=true
+org.eclipse.jdt.core.formatter.indent_statements_compare_to_body=true
+org.eclipse.jdt.core.formatter.indent_switchstatements_compare_to_cases=true
+org.eclipse.jdt.core.formatter.indent_switchstatements_compare_to_switch=false
+org.eclipse.jdt.core.formatter.indentation.size=4
+org.eclipse.jdt.core.formatter.insert_new_line_after_annotation=insert
+org.eclipse.jdt.core.formatter.insert_new_line_after_opening_brace_in_array_initializer=do not insert
+org.eclipse.jdt.core.formatter.insert_new_line_at_end_of_file_if_missing=do not insert
+org.eclipse.jdt.core.formatter.insert_new_line_before_catch_in_try_statement=do not insert
+org.eclipse.jdt.core.formatter.insert_new_line_before_closing_brace_in_array_initializer=do not insert
+org.eclipse.jdt.core.formatter.insert_new_line_before_else_in_if_statement=do not insert
+org.eclipse.jdt.core.formatter.insert_new_line_before_finally_in_try_statement=do not insert
+org.eclipse.jdt.core.formatter.insert_new_line_before_while_in_do_statement=do not insert
+org.eclipse.jdt.core.formatter.insert_new_line_in_empty_annotation_declaration=insert
+org.eclipse.jdt.core.formatter.insert_new_line_in_empty_anonymous_type_declaration=insert
+org.eclipse.jdt.core.formatter.insert_new_line_in_empty_block=insert
+org.eclipse.jdt.core.formatter.insert_new_line_in_empty_enum_constant=insert
+org.eclipse.jdt.core.formatter.insert_new_line_in_empty_enum_declaration=insert
+org.eclipse.jdt.core.formatter.insert_new_line_in_empty_method_body=insert
+org.eclipse.jdt.core.formatter.insert_new_line_in_empty_type_declaration=insert
+org.eclipse.jdt.core.formatter.insert_space_after_and_in_type_parameter=insert
+org.eclipse.jdt.core.formatter.insert_space_after_assignment_operator=insert
+org.eclipse.jdt.core.formatter.insert_space_after_at_in_annotation=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_at_in_annotation_type_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_binary_operator=insert
+org.eclipse.jdt.core.formatter.insert_space_after_closing_angle_bracket_in_type_arguments=insert
+org.eclipse.jdt.core.formatter.insert_space_after_closing_angle_bracket_in_type_parameters=insert
+org.eclipse.jdt.core.formatter.insert_space_after_closing_brace_in_block=insert
+org.eclipse.jdt.core.formatter.insert_space_after_closing_paren_in_cast=insert
+org.eclipse.jdt.core.formatter.insert_space_after_colon_in_assert=insert
+org.eclipse.jdt.core.formatter.insert_space_after_colon_in_case=insert
+org.eclipse.jdt.core.formatter.insert_space_after_colon_in_conditional=insert
+org.eclipse.jdt.core.formatter.insert_space_after_colon_in_for=insert
+org.eclipse.jdt.core.formatter.insert_space_after_colon_in_labeled_statement=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_allocation_expression=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_annotation=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_array_initializer=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_constructor_declaration_parameters=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_constructor_declaration_throws=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_enum_constant_arguments=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_enum_declarations=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_explicitconstructorcall_arguments=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_for_increments=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_for_inits=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_method_declaration_parameters=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_method_declaration_throws=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_method_invocation_arguments=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_multiple_field_declarations=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_multiple_local_declarations=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_parameterized_type_reference=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_superinterfaces=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_type_arguments=insert
+org.eclipse.jdt.core.formatter.insert_space_after_comma_in_type_parameters=insert
+org.eclipse.jdt.core.formatter.insert_space_after_ellipsis=insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_angle_bracket_in_parameterized_type_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_angle_bracket_in_type_arguments=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_angle_bracket_in_type_parameters=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_brace_in_array_initializer=insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_bracket_in_array_allocation_expression=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_bracket_in_array_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_annotation=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_cast=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_catch=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_constructor_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_enum_constant=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_for=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_if=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_method_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_method_invocation=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_parenthesized_expression=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_switch=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_synchronized=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_while=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_postfix_operator=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_prefix_operator=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_question_in_conditional=insert
+org.eclipse.jdt.core.formatter.insert_space_after_question_in_wildcard=do not insert
+org.eclipse.jdt.core.formatter.insert_space_after_semicolon_in_for=insert
+org.eclipse.jdt.core.formatter.insert_space_after_unary_operator=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_and_in_type_parameter=insert
+org.eclipse.jdt.core.formatter.insert_space_before_assignment_operator=insert
+org.eclipse.jdt.core.formatter.insert_space_before_at_in_annotation_type_declaration=insert
+org.eclipse.jdt.core.formatter.insert_space_before_binary_operator=insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_angle_bracket_in_parameterized_type_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_angle_bracket_in_type_arguments=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_angle_bracket_in_type_parameters=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_brace_in_array_initializer=insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_bracket_in_array_allocation_expression=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_bracket_in_array_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_annotation=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_cast=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_catch=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_constructor_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_enum_constant=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_for=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_if=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_method_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_method_invocation=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_parenthesized_expression=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_switch=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_synchronized=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_while=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_colon_in_assert=insert
+org.eclipse.jdt.core.formatter.insert_space_before_colon_in_case=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_colon_in_conditional=insert
+org.eclipse.jdt.core.formatter.insert_space_before_colon_in_default=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_colon_in_for=insert
+org.eclipse.jdt.core.formatter.insert_space_before_colon_in_labeled_statement=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_allocation_expression=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_annotation=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_array_initializer=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_constructor_declaration_parameters=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_constructor_declaration_throws=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_enum_constant_arguments=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_enum_declarations=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_explicitconstructorcall_arguments=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_for_increments=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_for_inits=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_method_declaration_parameters=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_method_declaration_throws=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_method_invocation_arguments=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_multiple_field_declarations=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_multiple_local_declarations=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_parameterized_type_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_superinterfaces=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_type_arguments=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_comma_in_type_parameters=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_ellipsis=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_angle_bracket_in_parameterized_type_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_angle_bracket_in_type_arguments=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_angle_bracket_in_type_parameters=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_annotation_type_declaration=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_anonymous_type_declaration=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_array_initializer=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_block=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_constructor_declaration=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_enum_constant=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_enum_declaration=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_method_declaration=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_switch=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_type_declaration=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_bracket_in_array_allocation_expression=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_bracket_in_array_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_bracket_in_array_type_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_annotation=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_annotation_type_member_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_catch=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_constructor_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_enum_constant=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_for=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_if=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_method_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_method_invocation=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_parenthesized_expression=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_switch=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_synchronized=insert
+org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_while=insert
+org.eclipse.jdt.core.formatter.insert_space_before_parenthesized_expression_in_return=insert
+org.eclipse.jdt.core.formatter.insert_space_before_postfix_operator=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_prefix_operator=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_question_in_conditional=insert
+org.eclipse.jdt.core.formatter.insert_space_before_question_in_wildcard=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_semicolon=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_semicolon_in_for=do not insert
+org.eclipse.jdt.core.formatter.insert_space_before_unary_operator=do not insert
+org.eclipse.jdt.core.formatter.insert_space_between_brackets_in_array_type_reference=do not insert
+org.eclipse.jdt.core.formatter.insert_space_between_empty_braces_in_array_initializer=do not insert
+org.eclipse.jdt.core.formatter.insert_space_between_empty_brackets_in_array_allocation_expression=do not insert
+org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_annotation_type_member_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_constructor_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_enum_constant=do not insert
+org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_method_declaration=do not insert
+org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_method_invocation=do not insert
+org.eclipse.jdt.core.formatter.keep_else_statement_on_same_line=false
+org.eclipse.jdt.core.formatter.keep_empty_array_initializer_on_one_line=false
+org.eclipse.jdt.core.formatter.keep_imple_if_on_one_line=false
+org.eclipse.jdt.core.formatter.keep_then_statement_on_same_line=false
+org.eclipse.jdt.core.formatter.lineSplit=80
+org.eclipse.jdt.core.formatter.number_of_blank_lines_at_beginning_of_method_body=0
+org.eclipse.jdt.core.formatter.number_of_empty_lines_to_preserve=1
+org.eclipse.jdt.core.formatter.put_empty_statement_on_new_line=true
+org.eclipse.jdt.core.formatter.tabulation.char=tab
+org.eclipse.jdt.core.formatter.tabulation.size=4
+org.eclipse.jdt.core.formatter.use_tabs_only_for_leading_indentations=false
diff --git a/org.spearce.egit.ui.test/All org.spearce.egit.ui tests.launch b/org.spearce.egit.ui.test/All org.spearce.egit.ui tests.launch
new file mode 100644
index 0000000..23a74e2
--- /dev/null
+++ b/org.spearce.egit.ui.test/All org.spearce.egit.ui tests.launch	
@@ -0,0 +1,41 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<launchConfiguration type="net.sf.swtbot.eclipse.ui.launcher.JunitLaunchConfig">
+<booleanAttribute key="append.args" value="true"/>
+<booleanAttribute key="askclear" value="false"/>
+<booleanAttribute key="automaticAdd" value="true"/>
+<booleanAttribute key="automaticValidate" value="false"/>
+<stringAttribute key="bootstrap" value=""/>
+<stringAttribute key="checked" value="[NONE]"/>
+<booleanAttribute key="clearConfig" value="true"/>
+<booleanAttribute key="clearws" value="true"/>
+<booleanAttribute key="clearwslog" value="false"/>
+<stringAttribute key="configLocation" value="${workspace_loc}/.metadata/.plugins/org.eclipse.pde.core/pde-junit"/>
+<booleanAttribute key="default" value="true"/>
+<booleanAttribute key="includeOptional" value="true"/>
+<stringAttribute key="location" value="${workspace_loc}/../junit-workspace"/>
+<listAttribute key="org.eclipse.debug.core.MAPPED_RESOURCE_PATHS">
+<listEntry value="/org.spearce.egit.ui.test"/>
+</listAttribute>
+<listAttribute key="org.eclipse.debug.core.MAPPED_RESOURCE_TYPES">
+<listEntry value="4"/>
+</listAttribute>
+<mapAttribute key="org.eclipse.debug.core.environmentVariables">
+<mapEntry key="LC_ALL" value="C"/>
+</mapAttribute>
+<stringAttribute key="org.eclipse.jdt.junit.CONTAINER" value="=org.spearce.egit.ui.test"/>
+<booleanAttribute key="org.eclipse.jdt.junit.KEEPRUNNING_ATTR" value="false"/>
+<stringAttribute key="org.eclipse.jdt.junit.TESTNAME" value=""/>
+<stringAttribute key="org.eclipse.jdt.junit.TEST_KIND" value="org.eclipse.jdt.junit.loader.junit3"/>
+<stringAttribute key="org.eclipse.jdt.launching.MAIN_TYPE" value=""/>
+<stringAttribute key="org.eclipse.jdt.launching.PROGRAM_ARGUMENTS" value="-os ${target.os} -ws ${target.ws} -arch ${target.arch} -nl en_US"/>
+<stringAttribute key="org.eclipse.jdt.launching.PROJECT_ATTR" value="org.spearce.egit.ui.test"/>
+<stringAttribute key="org.eclipse.jdt.launching.SOURCE_PATH_PROVIDER" value="org.eclipse.pde.ui.workbenchClasspathProvider"/>
+<stringAttribute key="org.eclipse.jdt.launching.VM_ARGUMENTS" value="-Dnet.sf.swtbot.search.timeout=500000"/>
+<stringAttribute key="pde.version" value="3.3"/>
+<stringAttribute key="product" value="org.eclipse.sdk.ide"/>
+<booleanAttribute key="show_selected_only" value="false"/>
+<booleanAttribute key="tracing" value="false"/>
+<booleanAttribute key="useDefaultConfig" value="true"/>
+<booleanAttribute key="useDefaultConfigArea" value="false"/>
+<booleanAttribute key="useProduct" value="true"/>
+</launchConfiguration>
diff --git a/org.spearce.egit.ui.test/META-INF/MANIFEST.MF b/org.spearce.egit.ui.test/META-INF/MANIFEST.MF
new file mode 100644
index 0000000..9059c4a
--- /dev/null
+++ b/org.spearce.egit.ui.test/META-INF/MANIFEST.MF
@@ -0,0 +1,19 @@
+Manifest-Version: 1.0
+Bundle-ManifestVersion: 2
+Bundle-Name: Test Plug-in
+Bundle-SymbolicName: org.spearce.egit.ui.test
+Bundle-Version: 0.4.0.qualifier
+Bundle-Activator: org.spearce.egit.ui.test.Activator
+Require-Bundle: org.eclipse.core.runtime,
+ org.spearce.egit.ui;bundle-version="0.4.0",
+ net.sf.swtbot.eclipse.finder;bundle-version="2.0.0",
+ net.sf.swtbot.eclipse.spy;bundle-version="2.0.0",
+ net.sf.swtbot.eclipse.ui;bundle-version="2.0.0",
+ net.sf.swtbot.finder;bundle-version="2.0.0",
+ org.eclipse.swt;bundle-version="3.4.0",
+ org.eclipse.ui;bundle-version="3.4.0",
+ org.eclipse.core.resources;bundle-version="3.4.0",
+ org.spearce.jgit;bundle-version="0.4.0",
+ org.apache.log4j;bundle-version="1.2.13"
+Bundle-ActivationPolicy: lazy
+Bundle-RequiredExecutionEnvironment: JavaSE-1.6
diff --git a/org.spearce.egit.ui.test/build.properties b/org.spearce.egit.ui.test/build.properties
new file mode 100644
index 0000000..34d2e4d
--- /dev/null
+++ b/org.spearce.egit.ui.test/build.properties
@@ -0,0 +1,4 @@
+source.. = src/
+output.. = bin/
+bin.includes = META-INF/,\
+               .
diff --git a/org.spearce.egit.ui.test/src/org/spearce/egit/ui/internal/sharing/GitCloneWizardTest.java b/org.spearce.egit.ui.test/src/org/spearce/egit/ui/internal/sharing/GitCloneWizardTest.java
new file mode 100644
index 0000000..393ce8b
--- /dev/null
+++ b/org.spearce.egit.ui.test/src/org/spearce/egit/ui/internal/sharing/GitCloneWizardTest.java
@@ -0,0 +1,480 @@
+package org.spearce.egit.ui.internal.sharing;
+
+import java.io.File;
+import java.io.FileOutputStream;
+import java.io.IOException;
+
+import net.sf.swtbot.eclipse.finder.SWTBotEclipseTestCase;
+import net.sf.swtbot.wait.Conditions;
+import net.sf.swtbot.widgets.SWTBotShell;
+import net.sf.swtbot.widgets.SWTBotTree;
+
+import org.eclipse.core.resources.ResourcesPlugin;
+import org.eclipse.core.runtime.Platform;
+import org.spearce.jgit.lib.Repository;
+
+/**
+ * UI Tests for the Git import wizard.
+ * <p>
+ * Only UI aspects are interesting.
+ * <p>
+ * TODO:
+ * <ul>
+ * <li>Failure at fetch step
+ * <li>Failure during fetch step
+ * <li>Failure post fetch step (bad repo?)
+ * </ul>
+ */
+public class GitCloneWizardTest extends SWTBotEclipseTestCase {
+	/**
+	 * Test that defaults and derived values in dialogs are set properly and
+	 * that cloning starts and stops properly for a normal run. It also samples
+	 * the cloned repository to see that a clone and checkout has occurred.
+	 * <p>
+	 * The clone is backgrounded so no import to the workspace, nor any sharing
+	 * occurs.
+	 *
+	 * @throws Exception
+	 */
+	public void testClone() throws Exception {
+		bot.view("Package Explorer").show();
+		bot.menu("File").click();
+		bot.menu("File").menu("Import...").click();
+		bot.shell("Import");
+
+		SWTBotTree tree = bot.tree(0);
+		tree.expandNode("Git").select("Git Repository");
+
+		bot.button("Next >").click();
+		bot.shell("Import Git Repository");
+		bot.textWithLabel("URI:").setText("git://www.jgit.org/EGIT");
+		assertSourceParams(null, "www.jgit.org", "/EGIT", "git", "", true, "",
+				"", false, false);
+		bot.button("Next >").click();
+
+		assertEquals("master", bot.table().getTableItem(0).getText());
+		assertTrue(bot.table().getTableItem(0).isChecked());
+		bot.button("Next >").click();
+
+		File destRepo = new File(new File(ResourcesPlugin.getWorkspace()
+				.getRoot().getLocation().toFile().getParent(),
+				"junit-workspace"), "EGIT");
+		assertEquals(destRepo.toString(), bot.textWithLabel("Directory:")
+				.getText());
+		assertEquals("master", bot.comboBoxWithLabel("Initial branch:")
+				.getText());
+		assertEquals("origin", bot.textWithLabel("Remote name:").getText());
+		bot.checkBox("Import projects after clone").deselect();
+		bot.button("Finish").click();
+
+		SWTBotShell shell2 = bot.shell("Cloning from git://www.jgit.org/EGIT");
+
+		// This is not a performance test. Allow lots of time to complete
+		bot.waitUntil(Conditions.shellCloses(shell2), 120000);
+
+		// Some random sampling to see we got something. We do not test
+		// the integrity of the repository here. Only a few basic properties
+		// we'd expect from a clone made this way, that would possibly
+		// not hold true given other parameters in the GUI.
+		Repository repository = new Repository(new File(destRepo, ".git"));
+		// we always have an origin/master
+		assertNotNull(repository.resolve("origin/master"));
+		// and a local master initialized from origin/master (default!)
+		assertEquals(repository.resolve("origin/master"), repository
+				.resolve("origin/master"));
+		// A well known tag
+		assertEquals("90b818e596660b813b6fcf68f1e9e9b62c615130", repository
+				.resolve("refs/tags/v0.4.0").name());
+		// lots of refs
+		assertTrue(repository.getAllRefs().size() >= 10);
+		// and a README in the working dir
+		assertTrue(new File(destRepo, "README").exists());
+		assertFalse(repository.getIndex().isChanged());
+		assertFalse(repository.getIndex().getEntry("README").isModified(
+				destRepo));
+		// No project have been imported
+		assertEquals(0,
+				ResourcesPlugin.getWorkspace().getRoot().getProjects().length);
+	}
+
+	/**
+	 * Basically the same as testClone, but using the same parameters will not
+	 * work because the destination already exists and so the UI will not let
+	 * the user finish the operation. This tests that case for default
+	 * parameters.
+	 *
+	 * @throws Exception
+	 */
+	public void testCloneDestExists() throws Exception {
+		File destRepo = new File(new File(ResourcesPlugin.getWorkspace()
+				.getRoot().getLocation().toFile().getParent(),
+				"junit-workspace"), "EGIT");
+		if (!destRepo.exists()) {
+			if (!destRepo.mkdirs())
+				throw new IOException("Ooops, failed to create " + destRepo);
+			new FileOutputStream(new File(destRepo, "afile")).close();
+		}
+		bot.view("Package Explorer").show();
+		bot.menu("File").click();
+		bot.menu("File").menu("Import...").click();
+
+		bot.shell("Import");
+
+		SWTBotTree tree = bot.tree(0);
+		tree.expandNode("Git").select("Git Repository");
+		bot.button("Next >").click();
+
+		bot.shell("Import Git Repository");
+		bot.textWithLabel("URI:");
+		bot.textWithLabel("URI:").setText("git://www.jgit.org/EGIT");
+		bot.button("Next >").click();
+
+		bot.button("Next >").click();
+
+		bot.checkBox("Import projects after clone").deselect();
+		assertFalse(bot.button("Finish").isEnabled());
+		assertEquals(" " + bot.textWithLabel("Directory:").getText()
+				+ " is not an empty directory.", bot.text(2/* ! */).getText());
+
+		// Need to close or no other test can be performed
+		bot.activeShell().close();
+	}
+
+	/**
+	 * Alter some parameters during clone
+	 * @throws IOException
+	 */
+	public void testCloneChangeSomeParameters() throws IOException {
+		bot.view("Package Explorer").show();
+		bot.menu("File").click();
+		bot.menu("File").menu("Import...").click();
+
+		bot.shell("Import");
+
+		SWTBotTree tree = bot.tree(0);
+		tree.expandNode("Git").select("Git Repository");
+		bot.button("Next >").click();
+
+		bot.shell("Import Git Repository");
+		bot.textWithLabel("URI:").setText("git://www.jgit.org/EGIT");
+		assertSourceParams(null, "www.jgit.org", "/EGIT", "git", "", true, "",
+				"", false, false);
+		bot.button("Next >").click();
+
+		// Select only two branches
+		for (int i = 0; i < bot.table().rowCount(); ++i)
+			bot.table().getTableItem(i).uncheck();
+		assertEquals(" At least one branch must be selected.", bot.text(0)
+				.getText());
+		assertFalse(bot.button("Next >").isEnabled());
+		bot.table().getTableItem("stable").check(); // will enable
+		assertTrue(bot.button("Next >").isEnabled());
+		bot.table().getTableItem("release").check();
+		bot.button("Next >").click();
+
+		File destRepo = new File(new File(ResourcesPlugin.getWorkspace()
+				.getRoot().getLocation().toFile().getParent(),
+				"junit-workspace"), "EGIT2");
+		bot.textWithLabel("Directory:").setText(destRepo.toString());
+		assertEquals("release", bot.comboBoxWithLabel("Initial branch:")
+				.getText());
+		bot.comboBoxWithLabel("Initial branch:").setSelection("stable");
+		assertEquals("origin", bot.textWithLabel("Remote name:").getText());
+		bot.textWithLabel("Remote name:").setText("src");
+		bot.checkBox("Import projects after clone").deselect();
+		bot.button("Finish").click();
+
+		SWTBotShell shell2 = bot.shell("Cloning from git://www.jgit.org/EGIT");
+
+		// This is not a performance test. Allow lots of time to complete
+		bot.waitUntil(Conditions.shellCloses(shell2), 120000);
+
+		// Some random sampling to see we got something. We do not test
+		// the integrity of the repo here. Only a few basic properties
+		// we'd expect from a clone made this way, that would possibly
+		// not hold true given othe parameters in the GUI.
+		Repository repository = new Repository(new File(destRepo, ".git"));
+		assertNotNull(repository.resolve("src/stable"));
+		assertNotNull(repository.resolve("src/release"));
+		// we didn't clone that one
+		assertNull(repository.resolve("src/master"));
+		// and a local master initialized from origin/master (default!)
+		assertEquals(repository.resolve("stable"), repository
+				.resolve("src/stable"));
+		// A well known tag
+		assertEquals("90b818e596660b813b6fcf68f1e9e9b62c615130", repository
+				.resolve("refs/tags/v0.4.0").name());
+		// lots of refs
+		assertTrue(repository.getAllRefs().size() >= 10);
+
+		// Skip testing working dir, we did that in #testClone
+	}
+
+	/**
+	 * Exercise editing of fields and verify that derived fields are updated and
+	 * enabled/disabled properly along with a proper error message when needed.
+	 * No clone is actually made.
+	 */
+	public void testParameterEditing() {
+		bot.view("Package Explorer").show();
+		bot.menu("File").click();
+		bot.menu("File").menu("Import...").click();
+		bot.shell("Import");
+
+		SWTBotTree tree = bot.tree(0);
+		tree.expandNode("Git").select("Git Repository");
+		bot.button("Next >").click();
+
+		bot.shell("Import Git Repository");
+		// Start the test now
+		bot.textWithLabel("URI:").setText("git://www.jgit.org/EGIT");
+		assertSourceParams(null, "www.jgit.org", "/EGIT", "git", "", true, "",
+				"", false, false);
+
+		bot.textWithLabel("URI:").typeText("X");
+		assertSourceParams(null, "www.jgit.org", "/EGITX", "git", "", true, "",
+				"", false, false);
+
+		bot.textWithLabel("URI:").setText("git://www.jgit.org/EGIT");
+		assertSourceParams(null, "www.jgit.org", "/EGIT", "git", "", true, "",
+				"", false, false);
+
+		bot.textWithLabel("URI:").setText("git://user:hi@www.jgit.org/EGIT");
+		assertSourceParams(" User not supported on git protocol.",
+				"www.jgit.org", "/EGIT", "git", "", true, "user", "hi", false,
+				false);
+		// UI doesn't change URI even when password is entered in clear text as
+		// part of URI. Opinions on this may vary.
+		assertEquals("git://user:hi@www.jgit.org/EGIT", bot.textWithLabel(
+				"URI:").getText());
+
+		bot.textWithLabel("URI:").setText("ssh://user@www.jgit.org/EGIT");
+		assertSourceParams(null, "www.jgit.org", "/EGIT", "git+ssh", "", true,
+				"user", "", true, true);
+
+		bot.textWithLabel("URI:").setText("ssh://user@www.jgit.org/EGIT");
+		assertSourceParams(null, "www.jgit.org", "/EGIT", "git+ssh", "", true,
+				"user", "", true, true);
+
+		bot.textWithLabel("URI:").setText("ssh://user:hi@www.jgit.org:33/EGIT");
+		assertSourceParams(null, "www.jgit.org", "/EGIT", "git+ssh", "33",
+				true, "user", "hi", true, true);
+
+		bot.textWithLabel("URI:").setText("ssh:///EGIT");
+		assertSourceParams(" Host required for ssh protocol.", "", "/EGIT",
+				"git+ssh", "", true, "", "", true, true);
+
+		bot.textWithLabel("URI:").setText("file:///some/place");
+		if (Platform.getOS().equals(Platform.OS_WIN32))
+			assertSourceParams(" " + System.getProperty("user.dir")
+					+ "\\.\\some\\place does not exist.", "", "/some/place",
+					"file", "", false, "", "", false, false);
+		else
+			assertSourceParams(" /some/place does not exist.", "",
+					"/some/place", "file", "", false, "", "", false, false);
+
+		// Now try changing some fields other than URI and see how the URI field
+		// gets changed
+		bot.textWithLabel("URI:").setText("ssh://user@www.jgit.org/EGIT");
+
+		// ..change host
+		bot.textWithLabel("Host:").setText("example.com");
+		assertEquals("ssh://user@example.com/EGIT", bot.textWithLabel("URI:")
+				.getText());
+		assertSourceParams(null, "example.com", "/EGIT", "git+ssh", "", true,
+				"user", "", true, true);
+
+		// ..change user
+		bot.textWithLabel("User:").setText("gitney");
+		assertEquals("ssh://gitney@example.com/EGIT", bot.textWithLabel("URI:")
+				.getText());
+		assertSourceParams(null, "example.com", "/EGIT", "git+ssh", "", true,
+				"gitney", "", true, true);
+
+		// ..change password
+		bot.textWithLabel("Password:").setText("fsck");
+		// Password is not written into the URL here!
+		assertEquals("ssh://gitney@example.com/EGIT", bot.textWithLabel("URI:")
+				.getText());
+		assertSourceParams(null, "example.com", "/EGIT", "git+ssh", "", true,
+				"gitney", "fsck", true, true);
+
+		// change port number
+		bot.textWithLabel("Port:").setText("99");
+		assertEquals("ssh://gitney@example.com:99/EGIT", bot.textWithLabel(
+				"URI:").getText());
+		assertSourceParams(null, "example.com", "/EGIT", "git+ssh", "99", true,
+				"gitney", "fsck", true, true);
+
+		// change protocol to another with user/password capability
+		bot.comboBoxWithLabel("Protocol:").setSelection("ftp");
+		assertEquals("ftp://gitney@example.com:99/EGIT", bot.textWithLabel(
+				"URI:").getText());
+		assertSourceParams(null, "example.com", "/EGIT", "ftp", "99", true,
+				"gitney", "fsck", true, true);
+
+		// change protocol to one without user/password capability
+		bot.comboBoxWithLabel("Protocol:").setSelection("git");
+		assertEquals("git://gitney@example.com:99/EGIT", bot.textWithLabel(
+				"URI:").getText());
+		assertSourceParams(" User not supported on git protocol.",
+				"example.com", "/EGIT", "git", "99", true, "gitney", "fsck",
+				false, false);
+
+		// change protocol to one without host capability
+		bot.comboBoxWithLabel("Protocol:").setSelection("file");
+		assertEquals("file://gitney@example.com:99/EGIT", bot.textWithLabel(
+				"URI:").getText());
+		assertSourceParams(" Host not supported on file protocol.",
+				"example.com", "/EGIT", "file", "99", false, "gitney", "fsck",
+				false, false);
+
+		// Local protocol with file: prefix. We need to make sure the
+		// local path exists as a directory so we choose user.home as
+		// that one should exist.
+		if (Platform.getOS().equals(Platform.OS_WIN32))
+			bot.textWithLabel("URI:").setText(
+					"file:///" + System.getProperty("user.home"));
+		else
+			bot.textWithLabel("URI:").setText(
+					"file://" + System.getProperty("user.home"));
+		assertSourceParams(null, "", System.getProperty("user.home").replace(
+				'\\', '/'), "file", "", false, "", "", false, false);
+
+		// Local protocol without file: prefix
+		bot.textWithLabel("URI:").setText(System.getProperty("user.home"));
+		assertSourceParams(null, "", System.getProperty("user.home").replace(
+				'\\', '/'), "file", "", false, "", "", false, false);
+
+		// On windows the use can choose forward or backward slashes, so add
+		// a case for forward slashes using the non prefixed local protocol.
+		if (Platform.getOS().equals(Platform.OS_WIN32)) {
+			bot.textWithLabel("URI:").setText(
+					System.getProperty("user.home").replace('\\', '/'));
+			assertSourceParams(null, "", System.getProperty("user.home")
+					.replace('\\', '/'), "file", "", false, "", "", false,
+					false);
+		}
+		bot.button("Cancel").click();
+	}
+
+	/**
+	 * Try not giving a hostname that does not exist. Should yield an error and
+	 * disable the next/finish buttons.
+	 */
+	public void testNoSuchHost() {
+		bot.view("Package Explorer").show();
+		bot.menu("File").click();
+		bot.menu("File").menu("Import...").click();
+		bot.shell("Import");
+
+		SWTBotTree tree = bot.tree(0);
+		tree.expandNode("Git").select("Git Repository");
+
+		bot.button("Next >").click();
+		bot.shell("Import Git Repository");
+		bot.textWithLabel("URI:").setText("git://no.example.com/EGIT");
+		assertSourceParams(null, "no.example.com", "/EGIT", "git", "", true,
+				"", "", false, false);
+		bot.button("Next >").click();
+		assertEquals(" git://no.example.com/EGIT: unknown host", bot.text(0)
+				.getText());
+		assertTrue(bot.button("Cancel").isEnabled());
+		assertTrue(bot.button("< Back").isEnabled());
+		assertFalse(bot.button("Next >").isEnabled());
+		assertFalse(bot.button("Finish").isEnabled());
+		bot.button("Cancel").click();
+	}
+
+	/**
+	 * Try connecting to a non-git socket.
+	 */
+	public void testWrongSocket() {
+		bot.view("Package Explorer").show();
+		bot.menu("File").click();
+		bot.menu("File").menu("Import...").click();
+		bot.shell("Import");
+
+		SWTBotTree tree = bot.tree(0);
+		tree.expandNode("Git").select("Git Repository");
+
+		bot.button("Next >").click();
+		bot.shell("Import Git Repository");
+		bot.textWithLabel("URI:").setText("git://www.jgit.org:80/EGIT");
+		assertSourceParams(null, "www.jgit.org", "/EGIT", "git", "80", true,
+				"", "", false, false);
+		bot.button("Next >").click();
+		assertEquals(" git://www.jgit.org:80/EGIT: not found.", bot.text(0)
+				.getText());
+		assertTrue(bot.button("Cancel").isEnabled());
+		assertTrue(bot.button("< Back").isEnabled());
+		assertFalse(bot.button("Next >").isEnabled());
+		assertFalse(bot.button("Finish").isEnabled());
+		bot.button("Cancel").click();
+	}
+
+	/**
+	 * Firewalled socket, no response.
+	 */
+	public void testTimeoutToHost() {
+		bot.view("Package Explorer").show();
+		bot.menu("File").click();
+		bot.menu("File").menu("Import...").click();
+		bot.shell("Import");
+
+		SWTBotTree tree = bot.tree(0);
+		tree.expandNode("Git").select("Git Repository");
+
+		bot.button("Next >").click();
+		bot.shell("Import Git Repository");
+		bot.textWithLabel("URI:").setText("git://www.example.com/EGIT");
+		assertSourceParams(null, "www.example.com", "/EGIT", "git", "", true,
+				"", "", false, false);
+		bot.button("Next >").click();
+		// Timeout messages are platform and locale dependent it seems. This
+		// test has only been tried on Linux and Windows. We assume
+		// that the test is run with an english locale for this test to pass.
+		// -nl en_US and environment LC_ALL=en_US (or possibly the "C" locale).
+		assertStartsWith(" git://www.example.com/EGIT: Connection timed out",
+				bot.text(0).getText());
+		assertTrue(bot.button("Cancel").isEnabled());
+		assertTrue(bot.button("< Back").isEnabled());
+		assertFalse(bot.button("Next >").isEnabled());
+		assertFalse(bot.button("Finish").isEnabled());
+		bot.button("Cancel").click();
+	}
+
+	private void assertStartsWith(String expect, String actual) {
+		if (actual.length() < expect.length())
+			assertEquals("Wrong start of message", expect, actual);
+		else
+			assertEquals("Wrong start of message", expect, actual.substring(0,
+					expect.length()));
+	}
+
+	private void assertSourceParams(String message, String expectHost,
+			String expectPath, String expectProtocol, String expectPort,
+			boolean enablePort, String expectUser, String expectPassword,
+			boolean enabledUser, boolean enabledPass) {
+		if (message != null) {
+			assertEquals(message, bot.text(6).getText());
+			assertFalse(bot.button("Next >").isEnabled());
+		} else {
+			assertEquals("Enter the location of the source repository.", bot
+					.text(6).getText());
+			assertTrue(bot.button("Next >").isEnabled());
+		}
+		assertEquals(expectHost, bot.textWithLabel("Host:").getText());
+		assertEquals(expectPath, bot.textWithLabel("Repository path:")
+				.getText());
+		assertEquals(expectProtocol, bot.comboBoxWithLabel("Protocol:")
+				.getText());
+		assertEquals(expectPort, bot.textWithLabel("Port:").getText());
+		assertEquals(enablePort, bot.textWithLabel("Port:").isEnabled());
+		assertEquals(expectUser, bot.textWithLabel("User:").getText());
+		assertEquals(expectPassword, bot.textWithLabel("Password:").getText());
+		assertEquals(enabledUser, bot.textWithLabel("User:").isEnabled());
+		assertEquals(enabledPass, bot.label("Password:").isEnabled());
+		assertEquals(enabledPass, bot.textWithLabel("Password:").isEnabled());
+	}
+}
diff --git a/org.spearce.egit.ui.test/src/org/spearce/egit/ui/test/Activator.java b/org.spearce.egit.ui.test/src/org/spearce/egit/ui/test/Activator.java
new file mode 100644
index 0000000..b6ecb00
--- /dev/null
+++ b/org.spearce.egit.ui.test/src/org/spearce/egit/ui/test/Activator.java
@@ -0,0 +1,50 @@
+package org.spearce.egit.ui.test;
+
+import org.eclipse.core.runtime.Plugin;
+import org.osgi.framework.BundleContext;
+
+/**
+ * The activator class controls the plug-in life cycle
+ */
+public class Activator extends Plugin {
+
+	// The plug-in ID
+	public static final String PLUGIN_ID = "org.spearce.egit.ui.test";
+
+	// The shared instance
+	private static Activator plugin;
+	
+	/**
+	 * The constructor
+	 */
+	public Activator() {
+	}
+
+	/*
+	 * (non-Javadoc)
+	 * @see org.eclipse.core.runtime.Plugins#start(org.osgi.framework.BundleContext)
+	 */
+	public void start(BundleContext context) throws Exception {
+		super.start(context);
+		plugin = this;
+	}
+
+	/*
+	 * (non-Javadoc)
+	 * @see org.eclipse.core.runtime.Plugin#stop(org.osgi.framework.BundleContext)
+	 */
+	public void stop(BundleContext context) throws Exception {
+		plugin = null;
+		super.stop(context);
+	}
+
+	/**
+	 * Returns the shared instance
+	 *
+	 * @return the shared instance
+	 */
+	public static Activator getDefault() {
+		return plugin;
+	}
+
+}
-- 
1.6.1.rc3.56.gd0306
